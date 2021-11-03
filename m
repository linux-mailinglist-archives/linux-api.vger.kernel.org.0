Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F73444907
	for <lists+linux-api@lfdr.de>; Wed,  3 Nov 2021 20:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhKCThm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Nov 2021 15:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhKCThl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 Nov 2021 15:37:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8431AC061203
        for <linux-api@vger.kernel.org>; Wed,  3 Nov 2021 12:35:04 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y26so7251540lfa.11
        for <linux-api@vger.kernel.org>; Wed, 03 Nov 2021 12:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9W4p+e3FH13k+KxnPIh2RI8UTA5IO2e2jpCzQxdx0A=;
        b=eiyfzbYMFqirulY9rvWU7fsfoRUFXGSyEstBw14iMFoIy7KSRFRIta/HFInm1amwID
         cgmAFIXZSS+HJMKrAPq9Ck8YWIREjD435tabu6Yy4rUbcEWyTlNPNS4DYqQIyu1587KY
         xg8i8IBgEqe4OUakIFzPsMUJb8wLGD6BO1sS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9W4p+e3FH13k+KxnPIh2RI8UTA5IO2e2jpCzQxdx0A=;
        b=nsZpv1zzHKGOfVwoNTV9BtRnEYjfO88eG8jzgw7XxCA2mu7iHO1DaF5+Bssvg4XV6f
         w7h6cZ9XVfghBsNYwAHzweSh9PKbTTz2MrQgz11D9fSrz6Qw/aCqC8TIJ8YXzh4aAEXo
         cLQCWs/4lY0Flt5OD6fGh2ReYAJ+HLl23AztAwGFINFTo6cTqYfcH+LvOK+KVOaaD66q
         Xg2Hq5TlWZ3lB5bFDMW1DLUAaH2tplkY9g/4dzY92MqvrB9O6vb0sLACjE1W0/lIn5gJ
         gr3gYp6rZsFaNB0Ii+RlIdpuzC2fbzRNe9v6/zgf1rkm1grGSqUC6EWnLxCRyfwKVeC1
         lFTQ==
X-Gm-Message-State: AOAM533r2Z5lTTJRRgS7FsPsHEphyGLSFL06PB8Nu6Smu4miW26HWID5
        HTC844yI85eWJMifjyizDy/qh4MqzqwktWhT
X-Google-Smtp-Source: ABdhPJxRHS2iqOnO5O9gjEIsoIvBxJKP5Vp67ptAhJSwaLWUb00XTjsgftFLIGTWyha0aJzXAMS9Nw==
X-Received: by 2002:a05:6512:44a:: with SMTP id y10mr235292lfk.9.1635968102661;
        Wed, 03 Nov 2021 12:35:02 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id e5sm269769ljj.61.2021.11.03.12.35.01
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 12:35:01 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id br12so5442653lfb.8
        for <linux-api@vger.kernel.org>; Wed, 03 Nov 2021 12:35:01 -0700 (PDT)
X-Received: by 2002:ac2:544a:: with SMTP id d10mr28557820lfn.141.1635968100697;
 Wed, 03 Nov 2021 12:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <878ry512iv.fsf@disp2133>
In-Reply-To: <878ry512iv.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Nov 2021 12:34:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivLcb3ELGSf=fM0u=PxP5m1=jRrVXDOr0+QJZRZggaHg@mail.gmail.com>
Message-ID: <CAHk-=wivLcb3ELGSf=fM0u=PxP5m1=jRrVXDOr0+QJZRZggaHg@mail.gmail.com>
Subject: Re: [GIT PULL] per signal_struct coredumps
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 3, 2021 at 12:07 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Please pull the per_signal_struct_coredumps-for-v5.16 branch

I've pulled it, but I'm not convinced about that odd extra merge
commit that contains the commentary.

That's what signed tags are for, and they have that explanation that
then makes it into the merge - plus they have the crypto signature to
show it all comes from you.

So that would have been the much better model than a fake extra merge.

But at least that extra merge did have explanations, so at least it
doesn't trigger me on _that_ level.

               Linus
