Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBA1D4860
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 21:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfJKTYo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 15:24:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38276 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbfJKTYo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 Oct 2019 15:24:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id u28so7805872lfc.5
        for <linux-api@vger.kernel.org>; Fri, 11 Oct 2019 12:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dk+GYmDk3Umblq0gC3zhCmwGbz+fKRKvXXa9PqPr9oI=;
        b=RKelw3XTZWr2fMIszm4fiPSJKM6JXno/egHsKyWt4ulwFQMu6s8kxaUjF9a1NatARA
         65uN4laUlTdl8ZdvrQailFcDmEk9gIgZTIaz5xoo01WNPvC19FeRMUmzCV3ux4iR0luW
         Hfue3vcmZOaTSmgI2TQ+rRt/J+LpNSEzf8wgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dk+GYmDk3Umblq0gC3zhCmwGbz+fKRKvXXa9PqPr9oI=;
        b=K1Dy1/WLqJVgjl7GAkj5o5wzpRSWIoT5cauBnc6HrWHSHG0kYKFuQNMYMmMtANZs5b
         BiXJiOOnCVR8wEaEBIFqoEm4pwRS9O1Yhw2ytK9WHgYead9nSafPoHcFAvZ69AsmBUgT
         LWMG+y+E62bzlK4/Y7iwJQ63v0oPmq3WD+ytFjb2mrWLJl7ehzHiuMulawcu72hZmkqL
         kfe33yq2Hz5AiLY4ZbYYzDANBPY641IBAQj+Ovcsxg1VFQDx7++lY35K1Oa0mbpL8gga
         6UctVJuWoj+Oq30RXOORjIBdOOEYCHy1udOFoxMF4VVACAXtRwnJAkm9PEv7v+UBVFEZ
         hElg==
X-Gm-Message-State: APjAAAUI/OtLQ8vdJBgb3OHhOGQayrkqQ/lTANtN6Ii7aNNcA+Y5HnZP
        0D0uiA/zza1vlpmhrcGfUgFTkEkE7Js=
X-Google-Smtp-Source: APXvYqwLIjjj7lM2kByKfBQiWOw6yrF6DS8RL32HDyC9EDSOK4iiATR6OPORfVhylXKDwY7286PbzQ==
X-Received: by 2002:ac2:5df0:: with SMTP id z16mr1925599lfq.36.1570821882103;
        Fri, 11 Oct 2019 12:24:42 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id z18sm2104971ljh.17.2019.10.11.12.24.40
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 12:24:40 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id d1so10846284ljl.13
        for <linux-api@vger.kernel.org>; Fri, 11 Oct 2019 12:24:40 -0700 (PDT)
X-Received: by 2002:a2e:8310:: with SMTP id a16mr4366223ljh.48.1570821879742;
 Fri, 11 Oct 2019 12:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191011135458.7399da44@gandalf.local.home> <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
 <20191011143610.21bcd9c0@gandalf.local.home>
In-Reply-To: <20191011143610.21bcd9c0@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 12:24:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_JH5-hC3yk8X3Ja8XMTuW68-ozuqZdMw7fcHpcpHuUw@mail.gmail.com>
Message-ID: <CAHk-=wh_JH5-hC3yk8X3Ja8XMTuW68-ozuqZdMw7fcHpcpHuUw@mail.gmail.com>
Subject: Re: [PATCH] tracefs: Do not allocate and free proxy_ops for lockdown
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Oct 11, 2019 at 11:36 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 11 Oct 2019 11:20:30 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > Willing to do that instead?
>
> Honestly, what you described was my preferred solution ;-)
>
> I just didn't want to upset the lockdown crowd if a new tracefs file
> was opened without doing this.

Well, since they introduced a bug in your code that killed your
machine with the patch _they_ did, I don't think they get to complain
when you fix it the way you (and me) want to...

Fair is fair.

             Linus
