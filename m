Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47327226DBE
	for <lists+linux-api@lfdr.de>; Mon, 20 Jul 2020 20:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgGTSGM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Jul 2020 14:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgGTSGL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Jul 2020 14:06:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D74FC0619D2
        for <linux-api@vger.kernel.org>; Mon, 20 Jul 2020 11:06:11 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x9so21228772ljc.5
        for <linux-api@vger.kernel.org>; Mon, 20 Jul 2020 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uI8ot/2J0X8mcn9Zfp2J49mB1lp08I2jN3wbAeSC/Pw=;
        b=Cz61HqTwOZ6IEwVnpU+vIjJ2UVZP/Mu4fKA2ydp8JL2VDpMC+nUU4axsRhH+TxIuMT
         7h9Jetot2Q2oMe1da303RP61HjMA+kS64YBC7m4CKaPJ6ZkKqgFan1xJh394/xLoayCV
         YJQKJ0gYeeODtQeM9+onNI6euuT5xsMXV1y1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uI8ot/2J0X8mcn9Zfp2J49mB1lp08I2jN3wbAeSC/Pw=;
        b=PBUzsRN80dQxNmgjDvTEYAqoVvWi1Rmhyg7zoAwgHtpyXm4u0A5K99qTNagRYXSOn8
         gq8WEz+7bjpPL8G9/v6NkXrmU4KMHNNIMG2z/66CeswJbrBdvhmpNQrGfGWcx+Zs0MIy
         1uJxu855zeAj26aqdTxbzfAPxZTN2elnvGRCSIDCAbpSoCS8qzNiCQ1cJEeTw7+FRHTZ
         ISpL4rN0pC6bK2Q2F5TN7QwGI10u+o4ZNZzoKj/dDLx7NtPfesXl6zIiqsdP7xPXtvQO
         QQUEgb5N3gOi2UN15qXbOmSgMOsyv/L9f3/XWlojmqHO4nm+jBaBs41S8WLS/mglEQkv
         ZPmA==
X-Gm-Message-State: AOAM5328E5uAn8UWzO4FgnjQDOvPRSz4e/fvyjikDeZRqS/c67k11mCS
        0f8G9HL+0IFUrIPOoirS+yE/rMC+hYo=
X-Google-Smtp-Source: ABdhPJxSblBRW/FfgCiYB444+dFpm+LKgFaWv2RcGSx1uHbsgOYCA+mhh+PCNTCHsyNBq0eSDDdYIw==
X-Received: by 2002:a2e:a17c:: with SMTP id u28mr10698774ljl.140.1595268369211;
        Mon, 20 Jul 2020 11:06:09 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id w24sm3913511lfl.17.2020.07.20.11.06.07
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 11:06:07 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id s9so1494563lfs.4
        for <linux-api@vger.kernel.org>; Mon, 20 Jul 2020 11:06:07 -0700 (PDT)
X-Received: by 2002:a05:6512:2082:: with SMTP id t2mr2412004lfr.142.1595268366796;
 Mon, 20 Jul 2020 11:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200720155902.181712-1-hch@lst.de> <20200720155902.181712-5-hch@lst.de>
In-Reply-To: <20200720155902.181712-5-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Jul 2020 11:05:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimKMPiGP6n_HQUJ1rQ_6cT6hZH5rjQa_nfAgjB1mug+A@mail.gmail.com>
Message-ID: <CAHk-=wimKMPiGP6n_HQUJ1rQ_6cT6hZH5rjQa_nfAgjB1mug+A@mail.gmail.com>
Subject: Re: [PATCH 04/24] fs: move the putname from filename_create to the callers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 20, 2020 at 8:59 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This allows reusing the struct filename for retries, and will also allow
> pushing the getname up the stack for a few places to allower for better
> handling of kernel space filenames.

I find this _very_ confusing.

Now the rule is that filename_create() does the putname() if it fails,
but not if it succeeds.

That's just all kinds of messed up.

It was already slightly confusing how "getname()" was paired with
"putname()", and how you didn't need to check for errors, but at least
it was easy to explain: "filename_create() will  check errors and use
the name we got".

That slightly confusing calling convention made the code much more
compact, and nobody involved needed to do error checks on the name
etc.

Now that "slightly confusing" convention has gone from "slightly" to
"outright", and the whole advantage of the interface has completely
gone away, because now you not only need to do the putname() in the
caller, you need to do it _conditionally_.

So please don't do this.

The other patches also all make it *really* hard to follow when
putname() is done - because depending on the context, you have to do
it when returning an error, or when an error was not returned.

I really think this is a huge mistake. Don't do it this way. NAK NAK NAK.

Please instead of making this all completely messy and completely
impossible to follow the rule about exactly who does "putname()" and
under what conditions, just leave the slight duplication in place.

Duplicating simple helper routines is *good*. Complex and
hard-to-understand and non-intuitive rules are *bad*.

You're adding badness.

                 Linus
