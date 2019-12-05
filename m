Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A17B11145D5
	for <lists+linux-api@lfdr.de>; Thu,  5 Dec 2019 18:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfLERZN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Dec 2019 12:25:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35736 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbfLERZM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Dec 2019 12:25:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id 15so3117481lfr.2
        for <linux-api@vger.kernel.org>; Thu, 05 Dec 2019 09:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcGyAgv2BiiKMB4o1JPjh3c4/KLE1QL1Cs5ZGEHCDIc=;
        b=h8R8qn2a8yMheUZxZicjSxy1mjJzLS/SXEZWNWhN2n29VR1l3aKAlm1cuqN3fZyRfk
         7RiJ2tHBwlnu/dxOScE0uVy3iZQZ7SYeh67Cd1w1vNd2lAU44JJHrRfgT90jo1Vxdgk6
         hfczULjbW6MoOj6k0umoQaFr+3JFVFJeh4/gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcGyAgv2BiiKMB4o1JPjh3c4/KLE1QL1Cs5ZGEHCDIc=;
        b=dfWjWa6vXou75b+ix7IZ/tD6M+EBUOx95Q/6IO3psZtmK3MQS2Q2zMniEARMcHilkr
         E5jekBx8SYxD012qmyElqWbCZLY2/Mt21BA5697g7GzNsnxYEh60vnJQyovQc7e451Cr
         2MsuB0m+4xwhT3F6EBK0MC+mUsSMHbPzmK+ITaobPQoNdJKM3KK0Lpc20no83aZ2wLpi
         Zat4D2GGX0pQ6yJeLVd5PpKeAgxRhVtsElY7sXMQPyvrYTcfIK8zlicvmnA7JEhBsC6e
         1KVDoh1jICc9RGF9GvHFjRrTEwX0mTR5O3iMSXpkn5mGr0neTrRgYeAL2ABI5KwTUclz
         LEjw==
X-Gm-Message-State: APjAAAV4rETePGot7TtpbdFf/l+1EAm4pA8iXde1Ol3fDZReW4G0o8Nn
        /+u++1Nwhftx7bkjHUej2a3RhWhr45A=
X-Google-Smtp-Source: APXvYqwhIMqDqWsOh8GLFeK4XINqJrCGlw38sLzeWn1GGELiOxWYbSDSXYN2pqRcc3Ao0AhfnPhu/Q==
X-Received: by 2002:ac2:4a91:: with SMTP id l17mr5974966lfp.75.1575566709938;
        Thu, 05 Dec 2019 09:25:09 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id z7sm3750678lfa.81.2019.12.05.09.25.08
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:25:08 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id c19so4449080lji.11
        for <linux-api@vger.kernel.org>; Thu, 05 Dec 2019 09:25:08 -0800 (PST)
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr3763207ljg.82.1575566707941;
 Thu, 05 Dec 2019 09:25:07 -0800 (PST)
MIME-Version: 1.0
References: <31452.1574721589@warthog.procyon.org.uk> <20191205125826.GK2734@twin.jikos.cz>
 <1593.1575554217@warthog.procyon.org.uk> <CAHk-=wgwwJ+ZEtycujFdNmpS8TjwCYyT+oHfV7d-GekyaX91xg@mail.gmail.com>
In-Reply-To: <CAHk-=wgwwJ+ZEtycujFdNmpS8TjwCYyT+oHfV7d-GekyaX91xg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 09:24:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_on1EAbVi1Q01i7=0_GL=nKmz6s9677YZf74H8=Sw0g@mail.gmail.com>
Message-ID: <CAHk-=wi_on1EAbVi1Q01i7=0_GL=nKmz6s9677YZf74H8=Sw0g@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: Notification queue preparation
To:     David Howells <dhowells@redhat.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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

On Thu, Dec 5, 2019 at 9:12 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It would be interesting to hear if somebody else is waiting on the
> read side too.

Looking once more at that commit, I find at least one bug, but I'm
pretty sure that's not the cause of this problem.

DavidH, watch out for things like this:

-       for (idx = 0; idx < pipe->nrbufs && rem < len; idx++)
+       for (idx = tail; idx < head && rem < len; idx++)

which is a completely buggy conversion.

You can't compare tail and head with an inequality, it gets the
wraparound case wrong.

But I found only one of those, and it's fuse-specific, plus the
overflow would take a long time to trigger, so I'm pretty sure this
isn't what DavidS is reporting.

               Linus
