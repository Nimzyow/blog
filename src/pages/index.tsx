import * as React from "react";
import type { HeadFC, PageProps } from "gatsby";
import Toast from "react-bootstrap/Toast";
import Container from "react-bootstrap/Container";
import Button from "react-bootstrap/Button";
import "bootstrap/dist/css/bootstrap.min.css";
import NavBar from "../components/NavBar";
import FormComponent from "../components/Form";
import { Link } from "gatsby";
import Layout from "../components/layout";
import { Card, CardGroup } from "react-bootstrap";

const WithHeaderExample = () => {
  return (
    <Card className="text-center mb-4">
      <Card.Header>Featured</Card.Header>
      <Card.Body>
        <Card.Title>Special title treatment</Card.Title>
        <Card.Text>
          With supporting text below as a natural lead-in to additional content.
        </Card.Text>
        <Button variant="primary">Go somewhere</Button>
      </Card.Body>
      <Card.Footer className="text-muted">2 days ago</Card.Footer>
    </Card>
  );
};

const GroupExample = () => {
  return (
    <CardGroup className="mb-3">
      <Card>
        <Card.Img variant="top" src="icon.png" />
        <Card.Body>
          <Card.Title>Blog 1</Card.Title>
          <Card.Text>
            This is some text for the blog 1 blog. It's going to be a good blog
            and it's going to be something I can occasionally add to
          </Card.Text>
        </Card.Body>
        <Card.Footer>
          <small className="text-muted">Last updated 3 mins ago</small>
        </Card.Footer>
      </Card>
      <Card>
        <Card.Img variant="top" src="holder.js/100px160" />
        <Card.Body>
          <Card.Title>Blog 2</Card.Title>
          <Card.Text>
            This card has supporting text below as a natural lead-in to
            additional content.{" "}
          </Card.Text>
        </Card.Body>
        <Card.Footer>
          <small className="text-muted">Last updated 3 mins ago</small>
        </Card.Footer>
      </Card>
      <Card>
        <Card.Img variant="top" src="holder.js/100px160" />
        <Card.Body>
          <Card.Title>Blog 3</Card.Title>
          <Card.Text>
            This is a wider card with supporting text below as a natural lead-in
            to additional content. This card has even longer content than the
            first to show that equal height action.
          </Card.Text>
        </Card.Body>
        <Card.Footer>
          <small className="text-muted">Last updated 3 mins ago</small>
        </Card.Footer>
      </Card>
    </CardGroup>
  );
};

const IndexPage: React.FC<PageProps> = () => {
  return (
    <Layout>
      <WithHeaderExample />
      <GroupExample />
      <GroupExample />
      <GroupExample />
    </Layout>
  );
};

export default IndexPage;

export const Head: HeadFC = () => <title>Home Page</title>;
