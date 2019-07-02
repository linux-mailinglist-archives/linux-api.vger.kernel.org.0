Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 865305DAE8
	for <lists+linux-api@lfdr.de>; Wed,  3 Jul 2019 03:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfGCBcn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Jul 2019 21:32:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43834 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbfGCBcm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Jul 2019 21:32:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so335021pfg.10
        for <linux-api@vger.kernel.org>; Tue, 02 Jul 2019 18:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OaclItD7NGDSjsey3tbhT+f/k4HSHLV82rGxlZ0Hupo=;
        b=kNWWevjxDFBtqAHSafz0REmEmitiL+6A7lBBl6Z9Ytlbj41dK1+CNpX10CgV6tqN3Q
         eUO2uHEK6BoSJvCJsVLJ5JTU5r2ZSOiSxxGple/5brcgy+DhHf1VnPyzTJOktf0jQ5Gq
         ipxFgLa4IjlJJWkBbWJhuJp/4xqjI/H7t+PIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OaclItD7NGDSjsey3tbhT+f/k4HSHLV82rGxlZ0Hupo=;
        b=WAvNj/wj1RxZUmRaSZmrm69aAds+dMuDwhvzWklv4CFHUbEPxWb5OQWTJPyGr757JY
         PjZILRAPunFeebO+oqIJHaKoiqX7uUlyc8x1vVbnePTKLBK5z3Lp/WWr4TMfQRENRs5Q
         /2iOafXKoYSUPoxcu8mTBaNPqHgzuwVFYLk6j2ZEd5pWpRwyxqSGwYTp0QtA+7+d6tU5
         Cmp68q0ox5iQF4It2rxhgnSnSZ3yNJUGGVdI8SD+gPrkOZomtDKoOsiJRVz60EfH4lZb
         cyxkPQGmpK4TX6utefkz3ICFjUGSgGlCIzYNXKDE8dTeBno5Ai2TYlEWVUFGbEbr7e20
         +WtA==
X-Gm-Message-State: APjAAAVZCrDiBpprcv1ZCHQAfZ5/0r1l3z1qn/GjunFADsSjCLEfIlQW
        smas1h5/Us/oNBXp7GykcHFZQg==
X-Google-Smtp-Source: APXvYqww3bvpNMLM4w4pBewDgte906pGeOLG/xtRE1fYclLJgRjEFZT5FyrXB5cCVp9gYsCY5g1ngA==
X-Received: by 2002:a17:90a:be08:: with SMTP id a8mr7519671pjs.69.1562101445606;
        Tue, 02 Jul 2019 14:04:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3sm48479pgv.21.2019.07.02.14.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 14:04:02 -0700 (PDT)
Date:   Tue, 2 Jul 2019 11:24:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        "linux-security@vger.kernel.org" <linux-security@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
Message-ID: <201907021115.DCD56BBABB@keescook>
References: <20190627201923.2589391-1-songliubraving@fb.com>
 <20190627201923.2589391-2-songliubraving@fb.com>
 <21894f45-70d8-dfca-8c02-044f776c5e05@kernel.org>
 <3C595328-3ABE-4421-9772-8D41094A4F57@fb.com>
 <CALCETrWBnH4Q43POU8cQ7YMjb9LioK28FDEQf7aHZbdf1eBZWg@mail.gmail.com>
 <0DE7F23E-9CD2-4F03-82B5-835506B59056@fb.com>
 <CALCETrWBWbNFJvsTCeUchu3BZJ3SH3dvtXLUB2EhnPrzFfsLNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWBWbNFJvsTCeUchu3BZJ3SH3dvtXLUB2EhnPrzFfsLNA@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 01, 2019 at 06:59:13PM -0700, Andy Lutomirski wrote:
> I think I'm understanding your motivation.  You're not trying to make
> bpf() generically usable without privilege -- you're trying to create
> a way to allow certain users to access dangerous bpf functionality
> within some limits.
> 
> That's a perfectly fine goal, but I think you're reinventing the
> wheel, and the wheel you're reinventing is quite complicated and
> already exists.  I think you should teach bpftool to be secure when
> installed setuid root or with fscaps enabled and put your policy in
> bpftool.  If you want to harden this a little bit, it would seem
> entirely reasonable to add a new CAP_BPF_ADMIN and change some, but
> not all, of the capable() checks to check CAP_BPF_ADMIN instead of the
> capabilities that they currently check.

If finer grained controls are wanted, it does seem like the /dev/bpf
path makes the most sense. open, request abilities, use fd. The open can
be mediated by DAC and LSM. The request can be mediated by LSM. This
provides a way to add policy at the LSM level and at the tool level.
(i.e. For tool-level controls: leave LSM wide open, make /dev/bpf owned
by "bpfadmin" and bpftool becomes setuid "bpfadmin". For fine-grained
controls, leave /dev/bpf wide open and add policy to SELinux, etc.)

With only a new CAP, you don't get the fine-grained controls. (The
"request abilities" part is the key there.)

-- 
Kees Cook
