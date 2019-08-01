Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B5A7E470
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 22:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbfHAUoX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Aug 2019 16:44:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40048 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfHAUoX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Aug 2019 16:44:23 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so22182264iom.7
        for <linux-api@vger.kernel.org>; Thu, 01 Aug 2019 13:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kEYB2+OVQo5XUoP0DBjTnNKzZvTb5NJlv5p6H9Nyzv4=;
        b=p9nP+P/1loHtaBCdy0RixW63mz45R3rvCZ00Zldzay+dbiKdcAlP60JiUO+vB9DPGE
         NQJ1C+W5QRgA7GRQUTDum4dZCx4LwgnvuxVsXej6GZylA+kvpVZq6l0dgut7812mYn35
         DsWqOMKrGeUGD4tPXmYcmWJx8fuBLkIxm3KMTmysQD92yPn1C5Vm+b1mi3yzYNgbfw2/
         Y8DRxS8fqk8/SDEMiHv8A4b1GCoQG4Xo4d3w8Q7d89vyRaK4T2aOw/ElbTU7zkWGpfdv
         PY4K3r3n6JTqdYh5mfC26n9HDI5B+8uPadncMj+1BwM8CqiGALvnDTb7ncp/F7ZNkpCx
         tO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEYB2+OVQo5XUoP0DBjTnNKzZvTb5NJlv5p6H9Nyzv4=;
        b=tLnbeBSQmc/c3e4xdb4qbAe17Akm0mqqMzaC3RKPV1WJLhIPtzuVQGBcY1Cfa/E2np
         46fKzJ5uEiG1YRHVx1QgltGz99byCHp+fGY/XN6o5HAxPdEqtKiI8WHwnduwvpTX/EoG
         ZaC79CfI5lJBU5eeEJkQO1Kjgrb2udpmSoIweroRN5EuWNy0o6OPdMdvy/E3JC+ok3cN
         KXTlR6hMqAfvzS6iBsleB+hrZ8cDIPTbgDbQRlEaacHFgKF3D4dWA1zEYu3PAqFOBW9n
         jU5KTw/AyxYq/X8gotFcVUbB3RXB+XWNPqseuvcgNp/ofZdqMJmGU+5WlyBrrmVu8E1u
         nPPA==
X-Gm-Message-State: APjAAAWss8nYLxAE8rJPJi0uENwhz6YALQKlX0ITS1hcDWflE6ZJRuzs
        1VSGdLTZfZKPyh4jnduxmxDKaVEy+WzqkKL5DLUP5UjxTFk=
X-Google-Smtp-Source: APXvYqwMBy0UyzznhL2qb2ZDkC6aceenmGV8TFVCHyy3LZ6BRmQiV8H2e9lPWkZWc9KUJul91Wj9CSU+s9ZSbxWcPHM=
X-Received: by 2002:a5d:97d8:: with SMTP id k24mr5004672ios.84.1564692261567;
 Thu, 01 Aug 2019 13:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
 <20190731221617.234725-20-matthewgarrett@google.com> <20190801161933.GB5834@linux-8ccs>
In-Reply-To: <20190801161933.GB5834@linux-8ccs>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 1 Aug 2019 13:44:10 -0700
Message-ID: <CACdnJutXUO9e0ti8tHtJ8z3xX6dcn4Cczbs-wMBRr07BM3iCvQ@mail.gmail.com>
Subject: Re: [PATCH V37 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
To:     Jessica Yu <jeyu@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Aug 1, 2019 at 9:19 AM Jessica Yu <jeyu@kernel.org> wrote:

> Hm, I don't think the doing parameter ended up being used in this function?

Thanks for catching that, I'll fix.
