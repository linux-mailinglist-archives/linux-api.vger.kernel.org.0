Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148F61DF05C
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2020 22:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbgEVUJ0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 May 2020 16:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730931AbgEVUJZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 22 May 2020 16:09:25 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5372AC05BD43
        for <linux-api@vger.kernel.org>; Fri, 22 May 2020 13:09:25 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id q8so11276034iow.7
        for <linux-api@vger.kernel.org>; Fri, 22 May 2020 13:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kuxuFImJXS+zMVZOoAVroX3dwfGV7HwfDMWssbC5C1A=;
        b=BzuSYVIpXA7rbNJiFsgqADe+GidjdLuozlif6nBYsRt6MchS6kYsgk18V3kI5F15Dx
         7VNYp9f9kKkWxdE9juayukb2eICEmxERuBAcGpn8aX1Q1jvanglLeWKvsSVhpJGj1C1i
         eFAXZDT+sRebaynrWit+kYbtLiiUZNaTpxeZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kuxuFImJXS+zMVZOoAVroX3dwfGV7HwfDMWssbC5C1A=;
        b=AOKb9dKwFNAKlunEGdrAW8P1gYlqLFqdHKPF7JTIgk3wT/H3YGA6qdkDqxHmZFcYeR
         8BaAgPezpTsfCCQmGDS2O3Ctu4y2SkWZZftMHnLOS0coBwz1HNhRs0ptTLF5Uv0rdbyx
         vEEOQgQiLDNNsH+qlx/UOUB8W7/FOY2N+0ckeA67YOwEvfT0TYxjskI3oqNZc7T8/VBa
         vEfLvxE0pMMmm9wEoY6TbwuivquwB7cxQdmAJQJhEz7PZEb9xp3wvw1dybigYvmsa1I3
         ri3pZynuPynLpe17sFmzmtiTiAu6b3MGPG+PT3s6Ipazw3qjzEHh7VDR3WbDTEI2RUgJ
         +Nog==
X-Gm-Message-State: AOAM531sAe+6ErMGwX2RFxfDm7q+sBH6sFQgdnfIo+Sg1/Ilie94jeca
        FDtUmbfX/OGPlzPnlffS+2CK/Q==
X-Google-Smtp-Source: ABdhPJzYYCoJX6l85G6846PNwAdJcv17n8+gt3PxXcY9YhA2VI1NbvUsdUKizD6X1uCV3XLQWunh3w==
X-Received: by 2002:a02:942a:: with SMTP id a39mr9629370jai.50.1590178164366;
        Fri, 22 May 2020 13:09:24 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id t22sm4064358iom.49.2020.05.22.13.09.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 13:09:23 -0700 (PDT)
Date:   Fri, 22 May 2020 20:09:22 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: seccomp feature development
Message-ID: <20200522200921.GB25319@ircssh-2.c.rugged-nimbus-611.internal>
References: <202005181120.971232B7B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005181120.971232B7B@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 18, 2020 at 02:04:57PM -0700, Kees Cook wrote:
> Hi!
> 
> This is my attempt at a brain-dump on my plans for nearish-term seccomp
> features. Welcome to my TED talk... ;)
> 
> These are the things I've been thinking about:
> 
> - fd passing
> - deep argument inspection
> - changing structure sizes
> - syscall bitmasks
> 
What's your take on enabling multiple filters with listeners being attached,
so that different seccomp interceptors can operate together. I'm wondering
how this would work.

One idea that I had is adding a new flag to the seccomp filter
installation -- something like NEXT_FILTER_COMPATIBLE. When a filter is
installed with a listener, it will check if all previous filters were
instaled with NEXT_FILTER_COMPATIBLE.

If the call is intercepted by a listener, and the return is overriden,
then it short-circuits, and the subsequent filters are not evaluated.

On the other hand, if the continue response is send, then the
subsequent filters are called.

What do you think?
