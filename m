Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B51661ABE2
	for <lists+linux-api@lfdr.de>; Sun, 12 May 2019 12:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfELKu2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 12 May 2019 06:50:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35584 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfELKu2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 12 May 2019 06:50:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id m20so8510028lji.2
        for <linux-api@vger.kernel.org>; Sun, 12 May 2019 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBbnEnlSGI+YZhytxcBPyDwhUUf9hqUjJsyebbdCrcw=;
        b=Bwee6W/aqjF3RtU9Pd++GRfF0phoAIMfmTwaL+3Nu8NDs6Et4DPm/F1C0PX7+IyOUI
         fj41FT6ceV5M+P7SetVJPMyYDB7uFUcFKruvefh1bd2kvdataPMuobAmTp0v5Vb33/n5
         WE2FQvUPk2ZhdYv1biJYsS7ilv3mBt2dX5GKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBbnEnlSGI+YZhytxcBPyDwhUUf9hqUjJsyebbdCrcw=;
        b=bCRrsCJrRUHIUk8GAwREtHV9/fEaFlXvaUj2kXLUWW9jyJfRENTpmz6EhQcU9PTNAf
         U+kLb3adMObj8k3KKVVHBpWKJ3hk0k6X7IjoErLG6QxWzKKOa92GfBpsoV9J3yIGb34I
         ANdUuiH982XKtP6x327EGCqRDB1Y9BrcN6W4ZHL89fNygxqYdVUwdSelko13e5pvjqan
         hlf6EpCDxXpP54TlTehJg1o5iZkjyTkk2Pwa78+OVm7NGt/fpLeQZj53OaEAjDih42RZ
         2myvwFT/GYugf5OAxpQr4bZIAtAI1xPwqVerAYo0d9l8BzQRxkWt4ltklTjUds4ezttA
         9EYQ==
X-Gm-Message-State: APjAAAUWC7fkzC5bbWuuDYjpZ7L/HCbBviHRJ2dOs23QYkQLucgld+W+
        veTzZnvm50Y3XEifvxTANFQeeyKTQEw=
X-Google-Smtp-Source: APXvYqyCFFENED7UBLP8mg2NR1un1Yg4Vb4RA6Fl1Lbkt1gtGnq+Jia3SNVJ8L/2/qHve4PU60/nnQ==
X-Received: by 2002:a2e:80d1:: with SMTP id r17mr10801813ljg.16.1557658226174;
        Sun, 12 May 2019 03:50:26 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id x141sm191245lfd.96.2019.05.12.03.50.25
        for <linux-api@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 03:50:25 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id f1so7001487lfl.6
        for <linux-api@vger.kernel.org>; Sun, 12 May 2019 03:50:25 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr10604583lfg.88.1557657862375;
 Sun, 12 May 2019 03:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com> <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
 <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
 <CALCETrUOj=4VWp=B=QT0BQ8X_Ds_b+pt68oDwfjGb+K0StXmWA@mail.gmail.com>
 <CAHk-=wg3+3GfHsHdB4o78jNiPh_5ShrzxBuTN-Y8EZfiFMhCvw@mail.gmail.com> <9CD2B97D-A6BD-43BE-9040-B410D996A195@amacapital.net>
In-Reply-To: <9CD2B97D-A6BD-43BE-9040-B410D996A195@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 May 2019 06:44:06 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh3dT7=SMjvSZreXSu36Cg7gsfSipLhfTz5ioDKXV5uHg@mail.gmail.com>
Message-ID: <CAHk-=wh3dT7=SMjvSZreXSu36Cg7gsfSipLhfTz5ioDKXV5uHg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andrew Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, May 11, 2019 at 7:37 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> I bet this will break something that already exists. An execveat() flag to turn off /proc/self/exe would do the trick, though.

Thinking more about it, I suspect it is (once again) wrong to let the
thing that does the execve() control that bit.

Generally, the less we allow people to affect the lifetime and
environment of a suid executable, the better off we are.

But maybe we could limit /proc/*/exe to at least not honor suid'ness
of the target? Or does chrome/runc depend on that too?

             Linus
