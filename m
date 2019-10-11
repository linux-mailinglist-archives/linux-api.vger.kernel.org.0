Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0D0D4773
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 20:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfJKSUv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 14:20:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37562 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbfJKSUv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 Oct 2019 14:20:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so7702926lff.4
        for <linux-api@vger.kernel.org>; Fri, 11 Oct 2019 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtOmkJTgWRCiTrhHWdgBsH5ShPsUcHo7wVkWA6GbOWw=;
        b=EJ30jg4up9E+EQq6XyhxqytCcLcjMUfxQCZiv0SKtis+tP16d1Y2taYObSlT7PNzA1
         LGvyUzk0LpW338viCdWts370M1zgQU++Pz96/cPXXnweOuhIbBFPJd8E204RnpU17teD
         QyB1KSmlKzHIBlccl6i4fb67lW6F+y5JeJUAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtOmkJTgWRCiTrhHWdgBsH5ShPsUcHo7wVkWA6GbOWw=;
        b=mHBl6kqgqAJOOeB5V1nS4uFAy1fG9lpJ0MVzcA9aV/0vbDOvrHtJfgyLBdEEDH56sk
         QdatGE6Oym/RWRNKpmENzF8lz6mwH5JCoo06o6YBoqfCglmofLWzxes6ropnB8QYFjZ+
         KCqN045/NJb9jQ7daXAmMpWGn45gum4AVfLxsxYkd4FLADwt7FjWsig3L45yzQuOE7hp
         loIT2aCfACfB+IbqxbUcsNoyWrK99mBL166jUryvFU7ySAG9JvQZyx1PL+mFluaO/RA7
         Wn1YRxfzMh/xu3rZKdq4booCVhKozKRX3BFzO+sygnpVlrxEAzMZEfg6F/tEmE5tmsEK
         Zsgw==
X-Gm-Message-State: APjAAAU1rFgwpBCc9pJC8RIPbIAPkHVFsSygliHcJw3ZNwQOZGZ34DDJ
        ydN4gimwDvBGQfA1uCvMJciDO8O7zQg=
X-Google-Smtp-Source: APXvYqxldNs19rDi1KUUbdh7KnobugrawfGKHWd52V3OOej2S32uSOcabTdNk8+yV+i+bT763143rA==
X-Received: by 2002:ac2:5bc1:: with SMTP id u1mr9768719lfn.182.1570818047422;
        Fri, 11 Oct 2019 11:20:47 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id h2sm2098499ljb.11.2019.10.11.11.20.46
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 11:20:46 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q64so10698956ljb.12
        for <linux-api@vger.kernel.org>; Fri, 11 Oct 2019 11:20:46 -0700 (PDT)
X-Received: by 2002:a2e:8315:: with SMTP id a21mr598855ljh.133.1570818045940;
 Fri, 11 Oct 2019 11:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191011135458.7399da44@gandalf.local.home>
In-Reply-To: <20191011135458.7399da44@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 11:20:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
Message-ID: <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
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

On Fri, Oct 11, 2019 at 10:55 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I bisected this down to the addition of the proxy_ops into tracefs for
> lockdown. It appears that the allocation of the proxy_ops and then freeing
> it in the destroy_inode callback, is causing havoc with the memory system.
> Reading the documentation about destroy_inode, I'm not sure that this is the
> proper way to handle allocating and then freeing the fops of the inode.

What is happening is that *because* it has a "destroy_inode()"
callback, it now expects destroy_inode to not just free free the proxy
ops, but to also schedule the inode itself for freeing.

Which that tracefs)destroy_inode() doesn't do.

So the inode never gets free'd at all - and you eventually run out of
memory due to the inode leak.

The trivial fix would be to instead use the "free_inode()" callback
(which is called after the required RCU grace period) and then free
the proxy op there _and_ call free_inode_nonrcu() too.

But I think your patch to not need a proxy op allocation at all is
probably better.

That said, I think the _best_ option would be to just getting rid of
the proxy fops _entirely_, and just make the (very few)
tracefs_create_file() cases do that LOCKDOWN_TRACEFS in their open in
the first place.

The proxy_fops was a hacky attempt to make the patch smaller. Your
"just wrap all ops" thing now made the patch bigger than just doing
the lockdown thing in all the callers.

In fact, many of them use tracing_open_generic(). And others - like
subsystem_open() already call tracing_open_generic() as part of their
open.

So from a quick glance, just making tracing_open_generic() do the
lockdown testing will take care of most cases.  Add a few other cases
to fill up the whole set, and your'e done.

Willing to do that instead?

                Linus
