Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94BD1E7EB5
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2020 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgE2N3g (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 May 2020 09:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgE2N3g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 May 2020 09:29:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C41C03E969
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 06:29:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q16so1174854plr.2
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ul4bJ2hVr4eFMvgXcJJG3Lk5xnruexNhHNt3lbvkhgo=;
        b=jomC+3YpX2h5ghollb7vstYdTLJfL89YS4x0N9EguV+ZadSoC1ELNk3f96zkiYdM/1
         mLgRfCSD1tbUwhWS+AKmDyYxUDBTyZRmxc0uBjyPyxdHS5uBzFJf2U/C6ecPajFwLT2p
         RnpGkCPBhOU5Y0RUVaqy0xBuJNiux9pSMfTkkYWWyYSNddeB9CgaV0fMUbEJ2xdL/nZn
         bH+D2sziqdsrWhf038N8YliE8ILRdpborib0xHrXQJxSs2MiRqYkF4hmIeAOVjELL3sa
         B7O8Jgi0DVvJPdV7E0GqPlE6sH37A/CkD+R36jyK4QXL0PpMgWvQEoVbTrIAwWvovVac
         YUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ul4bJ2hVr4eFMvgXcJJG3Lk5xnruexNhHNt3lbvkhgo=;
        b=eTqnBMWgZgfd5zr8vY7ZQN6brhM2MA4DlAFY2riMsgkWRibNU5ZjYnKkj7qPv0TYj9
         EhIK4noZCfEOdmCM3GlnP7SpKwawf3aulun/ZnNkI/2nG0PmqZH4FeiweaVa7LW13lJ6
         33JIv2yUbW83uAhG2TCaUlXWI/v6kulRnFxOTdWdfv8DlORfnxK+LQWSpmk7ON960FGg
         5mSuj8xsuLaIAlk5bgMnfy2xi2HvkCh5xP2KM4cD2ncSf7TO7yNlDnhoz6toHYpJK1v7
         So6L7yEvghhlaJRNWaiZuobTHx4piiivItD7LansDtzANfhd3CxzhbM5HwIzyZoM6+eA
         JLkA==
X-Gm-Message-State: AOAM530bhRn6diW7ODG0BxntPzJt2Y7q05r0McTLNPLytwTEbRGrk8EC
        CiR4m0VOnzZ2zWU6pgOOtHmNag==
X-Google-Smtp-Source: ABdhPJzWUcGNYAE5d+Ki4BC7Frg6ET6VIpx8ewNw8j3EZhGR7t9AXrMEr9myfb2Q3Dhw4Gav7Y846A==
X-Received: by 2002:a17:902:70c2:: with SMTP id l2mr2097683plt.237.1590758975603;
        Fri, 29 May 2020 06:29:35 -0700 (PDT)
Received: from cisco ([2001:420:c0c8:1002::476])
        by smtp.gmail.com with ESMTPSA id n19sm7706925pjo.5.2020.05.29.06.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 06:29:34 -0700 (PDT)
Date:   Fri, 29 May 2020 07:29:37 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sargun Dhillon <sargun@sargun.me>, christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v2 3/3] selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD
Message-ID: <20200529132937.GD429721@cisco>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-4-sargun@sargun.me>
 <202005290036.3FEFFDA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005290036.3FEFFDA@keescook>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 29, 2020 at 12:41:51AM -0700, Kees Cook wrote:
> On Thu, May 28, 2020 at 04:08:58AM -0700, Sargun Dhillon wrote:
> > +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
> > +
> > +	nextid = req.id + 1;
> > +
> > +	/* Wait for getppid to be called for the second time */
> > +	sleep(1);
> 
> I always rebel at finding "sleep" in tests. ;) Is this needed? IIUC,
> userspace will immediately see EINPROGRESS after the NOTIF_SEND
> finishes, yes?

Yes, I think we can just drop this, and I agree it's a good idea to do
so :)

Tycho
