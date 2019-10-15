Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3BFCD83B3
	for <lists+linux-api@lfdr.de>; Wed, 16 Oct 2019 00:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbfJOWca (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 15 Oct 2019 18:32:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37980 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732040AbfJOWca (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 15 Oct 2019 18:32:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so21927372ljj.5
        for <linux-api@vger.kernel.org>; Tue, 15 Oct 2019 15:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fon9Xqueqx/Fq0wGHnHqEDUCXyflZLUwsevU6fmx6jE=;
        b=SIEI+eyzsLvgKQSWy68fNU4waAO3JnvS6nzHr5/fZu5+F3lS+ninFSB5dUKCVryHZ+
         kl8H8QJRcmYfRoBpcYQdlcvyFYmbnE5AhMRuYRji7sgqsBgEDlqfBvGU7GUQWJu2UMf7
         6W/csLC8ZHTI+HN72RKiuRYhkxOOMexsvDhzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fon9Xqueqx/Fq0wGHnHqEDUCXyflZLUwsevU6fmx6jE=;
        b=AxZxdMCwj7vbAJtGxO0era/jnd7uVz+G4R5Myn4XbmabB9URPu//Cezrovi4XGaQOo
         RXbfw+JZcFh+UUUp+TDNRjDz0ubMFG43TCjZEjc7mXSh73uONwYkai62dKonikqdUtMz
         4EG9ENaCUY8tZ9uiVpbROsuvOWa2RzpUcJ2so7oEegYc9HrHprmBW/Uq7XsfKNOS6JFH
         1YRXarBuJhPGygADmiwxiO7J4VzCoFGoUPhA1WFDD1FKtZHWeLB1cwRfHCFH5tC3D6OF
         ATp8Pl8+GY2A/zUHQEbDgfh674l+h8kirVSwKPaFzEBb75Cy1ux6tZq7KstEoThqRZ5m
         ih8A==
X-Gm-Message-State: APjAAAWT5FtUGkPJ8YimiT2h7MZ1pcr3omLtai2T6/xDTzapjFfywhFw
        vtys2jCrGl8p1c2jgfzpbnuRyB0SQXQ=
X-Google-Smtp-Source: APXvYqxaWOPKHLbxCqMBeDG3YpZ0Hu3ZXU/5XaAeJZzUiXQ6PKPvWryFY7gAscpGE9ilL/Z1DZOToQ==
X-Received: by 2002:a2e:880e:: with SMTP id x14mr17367868ljh.42.1571178746711;
        Tue, 15 Oct 2019 15:32:26 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id v7sm5390910lfd.55.2019.10.15.15.32.24
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:32:25 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id u3so15738132lfl.10
        for <linux-api@vger.kernel.org>; Tue, 15 Oct 2019 15:32:24 -0700 (PDT)
X-Received: by 2002:a19:5504:: with SMTP id n4mr4230778lfe.106.1571178744104;
 Tue, 15 Oct 2019 15:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 15:32:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfCy+WCZ5SXZGi4QEhxXm=EjZjj4R9+o4q-QR3saMyfg@mail.gmail.com>
Message-ID: <CAHk-=whfCy+WCZ5SXZGi4QEhxXm=EjZjj4R9+o4q-QR3saMyfg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] pipe: Keyrings, Block and USB notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Aside from the two small comments, the pipe side looked reasonable,
but I stopped looking when the patches moved on to the notificaiton
part, and maybe I missed something in the earlier ones too.

Which does bring me to the meat of this email: can we please keep the
pipe cleanups and prepwork (and benchmarking) as a separate patch
series? I'd like that to be done separately from the notification
code, since it's re-organization and cleanup - while the eventual goal
is to be able to add messages to the pipe atomically, I think the
series makes sense (and should make sense) on its own.

          Linus
