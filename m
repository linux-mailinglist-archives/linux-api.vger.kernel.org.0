Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F396A1E875E
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2020 21:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgE2TMD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 May 2020 15:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgE2TMC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 May 2020 15:12:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB698C03E969
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 12:12:01 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh7so1605868plb.11
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 12:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=decs9gKQoFUz0IqtIufOW8Or3y9LkMuKp232OBe14mU=;
        b=eWDAuFvhZ08VeODhDiZrHCV0mEXsZEFVfJD5PJVxkwOzzUNwXhVnUBgtQQ6rFLGkSr
         /8YSN7+sVQCXA2mmJX/69E3rHjwJpjXHfCugaFZpsVtF4wlgic/bCNL/bp6qKO3cEc0R
         uX8OsB7tnNqNPrnf6hOoxDQ/nbd7AChkqmjV8JuycZQdlxORs9TYPUtZASzVlWPKxeCw
         tj+QZhCzKcnCy/D6NI39VojxtI9UGo7jm9HYLBww1TbgvxGYCPrmxY+F6St48W8P8bCb
         PNqp2lVnzbBnos/ITs+YF3TYIIfHpBrzDvdZ0vXfwj03poUCA4/atK9kfYGNulkPx8nv
         nRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=decs9gKQoFUz0IqtIufOW8Or3y9LkMuKp232OBe14mU=;
        b=k3YSGrcjnaH1/SK8FbzIptE5Ybrza9peW1/bAG2NbiFbkPgXXDRxuhRYP7S+04MzsY
         5xyq2oBy2sAVyItAxMCoE6jNYHddHI9wlAnnvQ4zbNpqBun+5ko70dIy8LSuViHg5a5/
         gFpicNvZdu1Y9dhgGo8Rit+ccy1z8xGX965wnLo3BeR8w2ZqeIRcZ4PvBctKg7Dro7Kp
         gJ1x97D4jXGPDHV3mwkZh2/OAcUdf23akLR2/nWjgTJxSYxR4bdyrY9D4+GvCzzoQPE1
         BHQq0Kim+eNxIVFxZnVLBaI7nd8NclWZe+mrq86DIbDwXHa8Evw3rz3TaT1EMSsHG8Rt
         GbFg==
X-Gm-Message-State: AOAM5328s7KXKF7o/Q6Dwjp8lCrZtbknLM+Ij7LlaC6ZW5cHLLExVwLy
        rtdDTKwhrHA8+bAa/5yD74BT0Q==
X-Google-Smtp-Source: ABdhPJyjcpckoDOu+R8Tw54TKJ153mJx2NUPVJpN+KQZyoYpj515kO0ch3WUU9bN7eI+lTMS2Jjt5Q==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8mr9901638plp.90.1590779520978;
        Fri, 29 May 2020 12:12:00 -0700 (PDT)
Received: from cisco ([2001:420:c0c8:1001::961])
        by smtp.gmail.com with ESMTPSA id y65sm8038790pfb.76.2020.05.29.12.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:12:00 -0700 (PDT)
Date:   Fri, 29 May 2020 13:12:07 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>, christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v2 3/3] selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD
Message-ID: <20200529191207.GH429721@cisco>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-4-sargun@sargun.me>
 <202005290036.3FEFFDA@keescook>
 <20200529184606.GB11153@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529184606.GB11153@ircssh-2.c.rugged-nimbus-611.internal>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 29, 2020 at 06:46:07PM +0000, Sargun Dhillon wrote:
> On Fri, May 29, 2020 at 12:41:51AM -0700, Kees Cook wrote:
> > On Thu, May 28, 2020 at 04:08:58AM -0700, Sargun Dhillon wrote:
> > > +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
> > > +
> > > +	nextid = req.id + 1;
> > > +
> > > +	/* Wait for getppid to be called for the second time */
> > > +	sleep(1);
> > 
> > I always rebel at finding "sleep" in tests. ;) Is this needed? IIUC,
> > userspace will immediately see EINPROGRESS after the NOTIF_SEND
> > finishes, yes?
> > 
> > Otherwise, yes, this looks good.
> > 
> > -- 
> > Kees Cook
> I'm open to better suggestions, but there's a race where if getppid
> is not called before the second SECCOMP_IOCTL_NOTIF_ADDFD is called,
> you will just get an ENOENT, since the notification ID is not found.

Ah, I see. The goal is to test the -EINPROGRESS here.

If you use write() instead of getppid(), and write to a socket, will
that work? The parent can block for the read, and once some thing has
been read it can test for -EINPROGRESS.

The user_notification_signal test does something similar.

Tycho
