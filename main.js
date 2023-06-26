const views = document.querySelector("#view-count");

const incrementView = async () => {
  try {
    let response = await fetch(
      "https://7cwwyp5iq7.execute-api.us-east-2.amazonaws.com/Production/views"
    );
    console.log(response.body);
    const data = await response.json();
    const { views: viewCount } = data;
    views.innerHTML = `Number of visitors: ${viewCount}`;
  } catch (error) {
    console.log(error);
  }
};

incrementView();
