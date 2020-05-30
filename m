Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858B71E9274
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2020 18:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgE3QHU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 30 May 2020 12:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgE3QHU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 30 May 2020 12:07:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E260EC03E969
        for <linux-api@vger.kernel.org>; Sat, 30 May 2020 09:07:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v2so1325449pfv.7
        for <linux-api@vger.kernel.org>; Sat, 30 May 2020 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DdoV3WWy/h0472QJ9/SAoLZAkGaClwMXT5quJJmxsPY=;
        b=Yv2vqOFOVVvE9Dma0cQRiNb4ghy2CvppzAooljl0Qg4QtEFe3avE17HBccN2PVZQTn
         X+nHYpD/wObrqKv3gOADULmXKqv+MOPSKhp82sbc6Qq2SUpIMdi4mSn5+n0TO/7TZV6f
         729i0RnuUIPSfOZTU+1NCeifM3JfyWzBk93xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DdoV3WWy/h0472QJ9/SAoLZAkGaClwMXT5quJJmxsPY=;
        b=NSnQAi7k4FuHgBziyVtnTq/Eqot7tKaaknX6ARUY6OI3uxU4OEdqWQkSdLsFReRBVG
         UfZm3Qp3D/VONKnJzR/qVbq5jMJCtTOJ5C08pgZ9E3j+ujR6mkfcqj9aNF9TlOA73hUz
         FiwJX6C9T3lzRvIafsj2SgPrFBDeWrumWJAM0oS1+MG34HA9v/yTPAjw8tpeq//OF8gX
         HD40LTnZn3KWpcvDSBgyGdJ5W/sFMeZeVqrG7i2Ea9lyyefqFHFSDDVjuo4d0mc59ZGq
         JNCatQm9n/WDBLbh0k1XoGrW7Xl0roCn5gR6AiBaXm+3jijWMbfVpXHm/AMGgLj0HRHA
         KTmw==
X-Gm-Message-State: AOAM5302JfjQTnnAhlzAfUL+pd45AOdCxFWYfZsz7MsuPTXaOdXIPIOD
        yAgFnrml5OoHyS0r26KHkADlcg==
X-Google-Smtp-Source: ABdhPJzgrVpWyvP7ynRKYSJeLdnlR9wiqZfBKsq4C6LeueLBM2R/nZqXBUaHjbpkDdB4+kFcKiLRrA==
X-Received: by 2002:a63:368c:: with SMTP id d134mr12833657pga.393.1590854838327;
        Sat, 30 May 2020 09:07:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k14sm8919617pgn.94.2020.05.30.09.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 09:07:17 -0700 (PDT)
Date:   Sat, 30 May 2020 09:07:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Sargun Dhillon <sargun@sargun.me>, christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <202005300834.6419E818A7@keescook>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook>
 <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
 <202005291926.E9004B4@keescook>
 <20200530140837.GM23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530140837.GM23230@ZenIV.linux.org.uk>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, May 30, 2020 at 03:08:37PM +0100, Al Viro wrote:
> On Fri, May 29, 2020 at 07:43:10PM -0700, Kees Cook wrote:
> 
> > Can anyone clarify the expected failure mode from SCM_RIGHTS? Can we
> > move the put_user() after instead? I think cleanup would just be:
> > replace_fd(fd, NULL, 0)
> 
> Bollocks.
> 
> Repeat after me: descriptor tables can be shared.  There is no
> "cleanup" after you've put something there.

Right -- this is what I was trying to ask about, and why I didn't like
the idea of just leaving the fd in the table on failure. But yeah, there
is a race if the process is about to fork or something.

So the choice here is how to handle the put_user() failure:

- add the put_user() address to the new helper, as I suggest in [1].
  (exactly duplicates current behavior)
- just leave the fd in place (not current behavior: dumps a fd into
  the process without "agreed" notification).
- do a double put_user (once before and once after), also in [1].
  (sort of a best-effort combo of the above two. and SCM_RIGHTS is
  hardly fast-pth).

-Kees

[1] https://lore.kernel.org/linux-api/202005282345.573B917@keescook/

-- 
Kees Cook
