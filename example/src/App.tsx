import * as React from 'react';

import {
  Dimensions,
  ScrollView,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
} from 'react-native';
import GifImage from '@lowkeychat/react-native-gif';

export default function App() {
  const [hide, setHide] = React.useState(false);
  const [paused, setPaused] = React.useState(false);

  const [gifs, setGifs] = React.useState([]);

  React.useEffect(() => {
    fetch('https://g.tenor.com/v1/trending?key=LIVDSRZULELA')
      .then((response) => response.json())
      .then((json) => {
        console.log('load', json.results);
        setGifs(json.results);
      })
      .catch((error) => {
        console.error('test', error);
      });
  }, []);

  return (
    <View style={styles.mainContainer}>
      <ScrollView
        style={styles.container}
        contentContainerStyle={styles.containerContent}
      >
        {!hide &&
          gifs.slice(0, 12).map(
            (
              g: { media: { nanogif: { url: string } }[] },
              index: number
            ): JSX.Element => (
              <GifImage
                source={{
                  uri: g.media[0].nanogif.url,
                }}
                fadeIn={true}
                style={styles.box}
                fadeInDuration={0.5}
                resizeMode={'cover'}
                paused={paused}
                onLoadEnd={() => console.log('onLoadEnd', index)}
              />
            )
          )}
      </ScrollView>
      <TouchableOpacity onPress={() => setHide(!hide)} style={styles.button}>
        <Text>Show or Hide</Text>
      </TouchableOpacity>
      <TouchableOpacity
        onPress={() => setPaused(!paused)}
        style={styles.button}
      >
        <Text>Pause</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  mainContainer: {
    justifyContent: 'center',
    alignItems: 'center',
    flexDirection: 'column',
    flexWrap: 'wrap',
  },
  container: {
    width: Dimensions.get('window').width,
    height: Dimensions.get('window').height * 0.8,
  },
  containerContent: {
    paddingTop: 100,
    justifyContent: 'center',
    alignItems: 'center',
    flexDirection: 'row',
    flexWrap: 'wrap',
  },
  box: {
    width: Dimensions.get('window').width * 0.2,
    height: Dimensions.get('window').width * 0.2,
    marginVertical: 20,
    margin: 15,
    borderRadius: 30,
    overflow: 'hidden',
  },
  button: {
    backgroundColor: '#b1bcff',
    padding: 20,
    marginTop: 5,
    borderRadius: 20,
  },
});
