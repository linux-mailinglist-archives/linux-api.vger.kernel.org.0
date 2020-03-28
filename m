Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E9D1969A3
	for <lists+linux-api@lfdr.de>; Sat, 28 Mar 2020 22:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgC1VxC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 28 Mar 2020 17:53:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45395 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgC1Vw6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 28 Mar 2020 17:52:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id b9so5014365pls.12
        for <linux-api@vger.kernel.org>; Sat, 28 Mar 2020 14:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NCEn6jiYkuBInipnn6zCj3DDSQcSKN3aqUSzXbErLKE=;
        b=Rq3TMeuPbUxxPHxnu2HIoc61sTFjgLQaNuXNOiePL7aKZf69jQ+dFmmXivkyriybNW
         vgQPzAGLknpxdaaBjXnKSMKfGascpAM2sveRdm1tiga7RQ5eBW5zwWegcXEF3OuBmBHO
         GYik2IFuQR2m0KTYbl2FbSa8Eqyejs4hrgep4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NCEn6jiYkuBInipnn6zCj3DDSQcSKN3aqUSzXbErLKE=;
        b=OiPzcrA3RjaPU1IWpSPVSETuFUhAxGRP1sfz79Ag1DU1InWYnEUqtTJaOIEBawwh8K
         XPasndSY015DmXHYfjwK0EIKblMeshpqQ4+MgG/98OowKEVOkL86O9bhtcWsRgSKvZvd
         JvOtaEMt7N0BEhZVlAXaTV3SGzdDesnmFYUY0JKDK1gjpOkoVjM8e7Zl0aWN+4ekAR5A
         G6KJkVKVo3x5JZ+jcLaSCfmwPtX+j5GNZrP1V+Z45nkElGr/auE1WdU76Iaq8g62wAKF
         M7mRx0qRmmDwoQq3qWkX5qw/umivBW2z3zdXnN755UPYek/U9NN1eNJC/crCbpXQcZY6
         H2Qg==
X-Gm-Message-State: ANhLgQ3sLA6+qiBa9Q1Bb8o97++z5oygtNcTG12gstx/33h8qE+UjhCj
        bd83+2NRTKGf9Y1n373vxg7wpw==
X-Google-Smtp-Source: ADFU+vuQs9Pb6Y6ncTb5sBNwy1tSr0+fCbtZKLnv4G2coXixK0YG2/jVjP1gF9qzdCIgU8SdYOki7g==
X-Received: by 2002:a17:90a:368f:: with SMTP id t15mr7297208pjb.23.1585432376997;
        Sat, 28 Mar 2020 14:52:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i189sm6840804pfc.148.2020.03.28.14.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 14:52:56 -0700 (PDT)
Date:   Sat, 28 Mar 2020 14:52:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v10 8/9] proc: use human-readable values for hidehid
Message-ID: <202003281451.88C7CBD23C@keescook>
References: <20200327172331.418878-1-gladkov.alexey@gmail.com>
 <20200327172331.418878-9-gladkov.alexey@gmail.com>
 <202003281321.A69D9DE45@keescook>
 <20200328211453.w44fvkwleltnc2m7@comp-core-i7-2640m-0182e6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328211453.w44fvkwleltnc2m7@comp-core-i7-2640m-0182e6>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Mar 28, 2020 at 10:14:53PM +0100, Alexey Gladkov wrote:
> On Sat, Mar 28, 2020 at 01:28:28PM -0700, Kees Cook wrote:
> > On Fri, Mar 27, 2020 at 06:23:30PM +0100, Alexey Gladkov wrote:
> > > [...]
> > > +	if (!kstrtouint(param->string, base, &result.uint_32)) {
> > > +		ctx->hidepid = result.uint_32;
> > 
> > This need to bounds-check the value with a call to valid_hidepid(), yes?
> 
> The kstrtouint returns 0 on success and -ERANGE on overflow [1].

No, I mean, hidepid cannot be just any uint32 value. It must be in the
enum. Is that checked somewhere else? It looked like the call to
valid_hidepid() was removed.

-- 
Kees Cook
