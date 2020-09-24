Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F82276B8E
	for <lists+linux-api@lfdr.de>; Thu, 24 Sep 2020 10:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgIXIP1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Sep 2020 04:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgIXIP1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Sep 2020 04:15:27 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6385BC0613D3
        for <linux-api@vger.kernel.org>; Thu, 24 Sep 2020 01:15:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so1409945pfo.12
        for <linux-api@vger.kernel.org>; Thu, 24 Sep 2020 01:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U2el13qFqXukTglGs7cvKDB4IKPjADIDv75hQ/9i9+E=;
        b=RVei7Bv4JMWbyvkyLgdFQFwYfIpkjYeRy3yleinFgOrptu3zTUE/9EyHI98NN+C/im
         x+96TesErw40CMW2cMSm5o5OF37NXz5frZ+kCND0pFHvWzwiM02cMCdZCtO/oRNKJHyH
         BqTHY9BpOHNgc+U56i6p8SKaUYIHr4tUX87jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U2el13qFqXukTglGs7cvKDB4IKPjADIDv75hQ/9i9+E=;
        b=RSYxhbkmXuJ1fVqtoJk673Y6FBF298IC/wuX4u4DXYkewdzmX8lIFke4WBaKXbZx3k
         KZmClsExNpQxeeaIz0vX1Ecs/PsgYtpF5Nan05RvwhmNreS+sqthAZpHs19w092V5Q7a
         zwmZQNtmOKaume3euwAnS7/Fb0WXHP8RbKqQ4QvXMX2UKxZ8pnxMZ2sYmmP5Ammm+JFF
         K9qb85n0AqC4ISA1hTddHsLyn7sqKh3UCZ7jPQtLATXR22lgYRIixH+1pZDw7AQVkOZM
         ayYdQuLMI4PcGk4f6126bNx8Qp1xHmD+Ox9KdJWoDwbuMTW4EH6z7lGQDrt2u2K5Imj3
         CX7w==
X-Gm-Message-State: AOAM532pdCZ47dg27AZNiV4v6e4gz6bxBKRSzSL48yhQ8B8tZJ24coeP
        LfmuN5xKcLlLCx3v5ElHPWtrFQ==
X-Google-Smtp-Source: ABdhPJxpG1Cp3bwo9P3GzvSQphN8aQzF+v4CUOKCDxb9oKuyX9qUhNPoAp+ludYIjdThKbRJpvKwPg==
X-Received: by 2002:a63:ea16:: with SMTP id c22mr2984137pgi.326.1600935326829;
        Thu, 24 Sep 2020 01:15:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q193sm1932012pfq.127.2020.09.24.01.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 01:15:25 -0700 (PDT)
Date:   Thu, 24 Sep 2020 01:15:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Valentin Rothberg <vrothber@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] seccomp: Implement constant action bitmaps
Message-ID: <202009240112.C48EF38EC2@keescook>
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-4-keescook@chromium.org>
 <CAG48ez0d80fOSTyn5QbH33WPz5UkzJJOo+V8of7YMR8pVQxumw@mail.gmail.com>
 <202009240018.A4D8274F@keescook>
 <CABqSeARV4prXOWf9qOBnm5Mm_aAdjwquqFFLQSuL0EegqeWEkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeARV4prXOWf9qOBnm5Mm_aAdjwquqFFLQSuL0EegqeWEkA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 24, 2020 at 03:07:23AM -0500, YiFei Zhu wrote:
> On Thu, Sep 24, 2020 at 2:37 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > This belongs over into patch 1.
> >
> > Thanks! I was rushing to get this posted so YiFei Zhu wouldn't spend
> > time fighting with arch and Kconfig stuff. :) I'll clean this (and the
> > other random cruft) up.
> 
> Wait, what? I'm sorry. We have already begun fixing the mentioned
> issues (mostly the split bitmaps for different arches). Although yes
> it's nice to have another implementation to refer to so we get the
> best of both worlds (and yes I'm already copying some of the code I
> think are better here over there), don't you think it's not nice to
> say "Hey I've worked on this in June, it needed rework but I didn't
> send the newer version. Now you sent yours so I'll rush mine so your
> work is redundant."?

I was trying to be helpful: you hadn't seen the RFC, and it was missing
the emulator piece, which I wanted to be small, so I put got it out the
door today. I didn't want you to think you needed to port the larger
emulator over, for example.

> That said, I do think this should be configurable. Users would be free
> to experiment with the bitmap on or off, just like users may turn
> seccomp off entirely. A choice also allows users to select different
> implementations, a few whom I work with have ideas on how to
> accelerate / cache argument dependent syscalls, for example.

I'm open to ideas, but I want to have a non-optional performance
improvement as the first step. :) "seccomp is magically faster" was my
driving goal.

-- 
Kees Cook
