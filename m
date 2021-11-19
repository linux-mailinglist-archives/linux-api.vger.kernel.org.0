Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC86457250
	for <lists+linux-api@lfdr.de>; Fri, 19 Nov 2021 17:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbhKSQGz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 19 Nov 2021 11:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbhKSQGy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 19 Nov 2021 11:06:54 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43814C061574
        for <linux-api@vger.kernel.org>; Fri, 19 Nov 2021 08:03:52 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso9226178pjb.0
        for <linux-api@vger.kernel.org>; Fri, 19 Nov 2021 08:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVl1y7dz5yzJ4ISPiOpYJmuusOkr3uxzfmH+anrgaX0=;
        b=lNLzz5grJcL0EywAhMja05SHW9eUygNXTKtZgQTXHqcNE3IcqDLr7U1Bc/rHf3k6Nk
         1mQ3kHTclvYs0jl3aSAbbDLNi6nu0sJX30vXpGyuO4zUJ+QE32QxlqFT6XWNep4MMz3W
         hX7TiTqGvoo24R7EPvxePcX71JCNKLq9DLI+G+pE7y7GACDF3kPbqfPgGeg6PTMk0Tl3
         r922k7X3j6boaoG3JHogizBD7db0bKuztYPCXmqGV3N77n8dkB14ZEuRVo6VSQzcsJfe
         uTbYjndK+PCGFaSP9fsT3WWSO1WEW/jkbuT4OaKIqs0DZCSIQLiOI7G/82vvUiNhqBiq
         IpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVl1y7dz5yzJ4ISPiOpYJmuusOkr3uxzfmH+anrgaX0=;
        b=F6HHV26Gocr9tNpVq4KyvgCWauqZVnp8WJrn8ez+2Q0u7h54rvyyMRwMdRXhby2j2W
         yZpuICsRboN9J+eSxraS5SLiI1tTFt+0US2ULd+ENXjEckX43U9El4w4BuSsgwl/RtwK
         68FE157pSVEvbwK/+rIFibVA7iokrUhcIZvky3v/kTVqalN7wAXLSAUPhOC4zU5l20m3
         KTVrMVcGdLWJfvxz/rMvL0LiIHyM9LiVOKJ/05xP1+qAISK+S6vxbTkjac5HhwYvibiT
         5YM3I850GpvqoYkVhDKZnELjkLdDNxETMSw06ZWQLns3rjWbPSEgFHJvl5N/CzklftoB
         hbPQ==
X-Gm-Message-State: AOAM532lTTCYq0KWCaR2KVyOl4A603gWDJ/3zYo58rAmAXYnGZ9+BPkX
        dO/qz2baa4umtq/+rQqyXxzaiybqanZkmwlp
X-Google-Smtp-Source: ABdhPJy0I7OeJBwYUukJb+gm4HMPcsPZFQFz2Io92uNtCvJbhNfZYOtwBBIchHRWXe+X3HstC7hC4A==
X-Received: by 2002:a17:90b:3a83:: with SMTP id om3mr778565pjb.211.1637337831717;
        Fri, 19 Nov 2021 08:03:51 -0800 (PST)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id o4sm11067326pjq.23.2021.11.19.08.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:03:50 -0800 (PST)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Robert O'Callahan <rocallahan@gmail.com>
Subject: Re: [PATCH 6/6] coredump: Limit coredumps to a single thread group
Date:   Fri, 19 Nov 2021 08:03:48 -0800
Message-Id: <20211119160348.22409-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <87y27mvnke.fsf@disp2133>
References: <87y27mvnke.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> Solve this by making a userspace visible change to only kill a single
> process/thread group. [...] With LinuxThreads long gone I don't
> expect anyone to have a notice this behavior change in practice.

FWIW rr's test suite does have an explicit test that we correctly record and 
replay the old behavior. We don't actually care what that behavior is though,
so we will update our tests.

- Kyle
