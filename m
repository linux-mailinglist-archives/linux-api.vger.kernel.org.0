Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 285BD8383B
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2019 19:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfHFRvh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 6 Aug 2019 13:51:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34336 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfHFRvh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Aug 2019 13:51:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so35756985pgc.1
        for <linux-api@vger.kernel.org>; Tue, 06 Aug 2019 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cmITogLLcRG4iTHNbutBPgjm6/NJWAG+3y9EkrkrJZo=;
        b=MghVKOu6eeZLipUB6d97Kjy62uVwlud2+SWC4WRxUucdudAw2D1RfdhaXBekNyfsWY
         2dZv751LYEJUdJolLijpIkZEpKf8U8z+7Bpx4QUwtkYAXm4r1GrMK3JSgrwTZ9JumrtS
         NoqhNZ2l1eYbmKvel4aa+y9aHh1X5vIJZywyWmo+loC+0ShHt87cA9pNFWz5Dz8gbjjm
         lJs9uAILgxcuUVRrg30uozVAJzMU/7T6sUnQLT3QWOymEzAH8QiqFCyaeRIhu87DsJkl
         70UAqtpMrvBqTnubBMQVfIlVWbb2hBYInMJoe9GReC2sisrGj21CqjIjN6TScYNCKRzS
         p8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cmITogLLcRG4iTHNbutBPgjm6/NJWAG+3y9EkrkrJZo=;
        b=A77EMNVBtzwDgXZWQGgp381qMYo4K2bbafl0gQAMRCA2YS4Jnn7wxqn2uX9qb2V2KM
         /zuJs6jrG8YsVyPmpi/OnTSWJxhwue7TfF2nqrpxwyH0HC3ZEPkxhJ5zSwNR+TFTEDjI
         98EkCcgSDs+IFDheulXJLMJ/YyQ3vzQiHRz/3Ezp3Y4MfTFILL+2Gg8bjZxH0cakTPrv
         QkSet04wn28p61KTLu4CNKeeNxkJeZadaWCcN49Bhf+V5ZdVf5RPqIXHc8CRBCdOHAvM
         aJo1H50WilICRlOUfKyYfZT9+Cz+ARxfBdgM3pHfzWksHJXNtKopO2vtMG1BB9BfjnlU
         zDHg==
X-Gm-Message-State: APjAAAU7/N4PS/bx7S8k9CHqPwaO3epQjuljJ52DOptAgkkQsxV61UGl
        GTEw+CcOwFmRGcv3g/KzP7ThkQ==
X-Google-Smtp-Source: APXvYqxpVl/tGMg2JjbrMVqSOyH0ltHXt6gTrp0/EE+BK/+EcosirHoQn0MloaIgJY4ojgh0D997pw==
X-Received: by 2002:a62:764d:: with SMTP id r74mr5145614pfc.110.1565113896428;
        Tue, 06 Aug 2019 10:51:36 -0700 (PDT)
Received: from brauner.io (c-67-180-61-213.hsd1.ca.comcast.net. [67.180.61.213])
        by smtp.gmail.com with ESMTPSA id 201sm105587433pfz.24.2019.08.06.10.51.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 10:51:35 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date:   Tue, 6 Aug 2019 19:51:33 +0200
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     christian@brauner.io, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, dancol@google.com,
        tglx@linutronix.de, jannh@google.com, dhowells@redhat.com,
        mtk.manpages@gmail.com, luto@kernel.org, akpm@linux-foundation.org,
        oleg@redhat.com, cyphar@cyphar.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 2/2] tests: add pidfd poll tests
Message-ID: <20190806175132.bx3yi44wmcfjcrli@brauner.io>
References: <20190726162226.252750-1-surenb@google.com>
 <20190726162226.252750-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190726162226.252750-2-surenb@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 26, 2019 at 09:22:26AM -0700, Suren Baghdasaryan wrote:
> This adds testing for polling on pidfd of a process being killed. Test runs
> 10000 iterations by default to stress test pidfd polling functionality.
> It accepts an optional command-line parameter to override the number or
> iterations to run.
> Specifically, it tests for:
> - pidfd_open on a child process succeeds
> - pidfd_send_signal on a child process succeeds
> - polling on pidfd succeeds and returns exactly one event
> - returned event is POLLIN
> - event is received within 3 secs of the process being killed
> 
> 10000 iterations was chosen because of the race condition being tested
> which is not consistently reproducible but usually is revealed after less
> than 2000 iterations.
> Reveals race fixed by commit b191d6491be6 ("pidfd: fix a poll race when setting exit_state")
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Applied-to:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=pidfd

Tracked-in:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=for-next
