Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA448114814
	for <lists+linux-api@lfdr.de>; Thu,  5 Dec 2019 21:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfLEU1O (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Dec 2019 15:27:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43362 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbfLEU1O (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Dec 2019 15:27:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so5068541ljm.10
        for <linux-api@vger.kernel.org>; Thu, 05 Dec 2019 12:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2nboj5xrRkV1yqHjA0Aj2mbWgmjh4x0SrJcMaszVtA=;
        b=TY6MoxQFBEklRwMxXtPk7pq3Wq5Rwa2J/YtugYsq/w1lH9+ERuu6f1+z8+8JuKIiKx
         YDkuPczmV+9Qf+ENZhlePKKmJs1rLUEQ7rx1SKksdo9OxMTgxyWfNyX7ZM9ZSUbccBnx
         JYw40/VtEd257BEbFslSJIyKBygobO7WiYq+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2nboj5xrRkV1yqHjA0Aj2mbWgmjh4x0SrJcMaszVtA=;
        b=PtzC0ixqmIdjDe3FqckONqa08sAu+V8iVqDM4C7SdgGbZUMw1LtO6Lmnp2diLqeb+m
         gdLbBCGarI4413nws/e2z84Nmtgd4Ranp/imB9qOqvUyijEMYl5LYl0wqvk28tRlRFGP
         7+PgSFMwPiGOG4AACxEdNqnhebdzGg84TrnQ1jZjMFS2kROehDcAjuWcgqzdEJvrHqSi
         w5L5w5P154/74szLXjal/2ibhGAOGLPUH+zSIPas7SXVpgIkPySBcRRxxd7lngfrxqha
         5GceZf40Dg7d22SC+lc+wJimu1yjwR73oGXA7ujpdXyRabs25iI1UP1qwPSVJrrChwtm
         MEDQ==
X-Gm-Message-State: APjAAAUlW/MIA1S+IvxN1oU9wvDIsKP8Mc/4TyBKnAHq5CrRvBbmSghV
        RYmFxwg4zYCc75ju6eMQXyJBE7yzDuw=
X-Google-Smtp-Source: APXvYqyBCNRfNjJ7BhzIKON79IPxUGUjoe/dxnlXIqP2or8jcm+YCzOiwYAyPah0RSeHc609cFOsnw==
X-Received: by 2002:a05:651c:112d:: with SMTP id e13mr5748028ljo.99.1575577630856;
        Thu, 05 Dec 2019 12:27:10 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id i19sm5715580ljj.24.2019.12.05.12.27.09
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 12:27:09 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id d20so5057928ljc.12
        for <linux-api@vger.kernel.org>; Thu, 05 Dec 2019 12:27:09 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr4294750ljn.48.1575577628995;
 Thu, 05 Dec 2019 12:27:08 -0800 (PST)
MIME-Version: 1.0
References: <31555.1574810303@warthog.procyon.org.uk>
In-Reply-To: <31555.1574810303@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 12:26:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+_n63ps_-Rvwgo4S7rd2eLAVcJwbZee7iHZaO+1hvYQ@mail.gmail.com>
Message-ID: <CAHk-=wj+_n63ps_-Rvwgo4S7rd2eLAVcJwbZee7iHZaO+1hvYQ@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: General notification queue
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
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

On Tue, Nov 26, 2019 at 3:18 PM David Howells <dhowells@redhat.com> wrote:
>
> Can you consider pulling my general notification queue patchset after
> you've pulled the preparatory pipework patchset?  Or should it be deferred
> to the next window?

So it's perhaps obvious by now, but I had delayed this pull request
because I was waiting to see if there were any reports of issues with
the core pipe changes.

And considering that there clearly _is_ something going on with the
pipe changes, I'm not going to pull this for this merge window.

I'm obviously hoping that we'll figure out what the btrfs-test issue
is asap, but even if we do, it's too late to pull stuff on top of our
current situation right now.

I suspect this is what you expected anyway (considering your own query
about the next merge window), but I thought I'd reply to it explicitly
since I had kept this pull request in my "maybe" queue, but with the
pipe thread from this morning it's dropped from that.

            Linus
