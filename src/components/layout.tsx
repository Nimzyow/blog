import * as React from "react";
import NavBar from "./NavBar";
import { Container } from "react-bootstrap";

const Layout = ({ children }: { children: React.ReactNode }) => {
  return (
    <div className="d-flex flex-column align-items-center w-100">
      <div className="w-100 bg-white">
        <div
          className="d-flex flex-column w-100"
          style={{ minHeight: "100vh", backgroundColor: "black" }}
        >
          <NavBar />
          <Container>{children}</Container>
        </div>
      </div>
    </div>
  );
};

export default Layout;
