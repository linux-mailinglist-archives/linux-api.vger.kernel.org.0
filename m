Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E283E76F7A
	for <lists+linux-api@lfdr.de>; Fri, 26 Jul 2019 19:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfGZRHc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Jul 2019 13:07:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40627 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfGZRHb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Jul 2019 13:07:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so24800080pfp.7
        for <linux-api@vger.kernel.org>; Fri, 26 Jul 2019 10:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bS9fLvgPfVAg2OSCXOIsqMJpT25qiH0bC1jmAoaZ02w=;
        b=NCCJAR+Za7x3HaI8H5CFemHhLHGi3ev3MyV5WZl6zAmaxI8OUei868E/4fIbbi8NYf
         JVsMGzQbOfELxLHWUyNslJINjJvSI23zCdoPTHtmWiwKPX8rmLbwreOy023i8Uerom1w
         pHcYS8RdoXLSF16XXrQIP91pHB3W5r3YHZh9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bS9fLvgPfVAg2OSCXOIsqMJpT25qiH0bC1jmAoaZ02w=;
        b=L18Ic5SUl0tTePtkDyik88tE7xGujV1rKNVZAYDrPlSkUtROUPHbJ5aZ1cl8v8IvAW
         +WH4XQ28V2CeoRyoY+IpQ+fiaQKgZ/r/ZDqEzI63zpD+NqdO1TI4rjYAf8+6FfNgIP/f
         Br5crFSSfyLwHUJy2gMhk0k1zjVeIUL/h5UcVchWXb/q+tlQqzwemnhfCDDV+nTgcyy8
         9j1EcOOS0aMSkT1Y0GIWloNEBakuVyhywUMqD00mN7FH/q2ohzQu4+owIl5f5nX0rvde
         PQJQ5YfF98Z7EMQpRYICSJMsW8RRA7Afvpb+hAPkQc/My4tLVRmPH4ZA0+HqAesuV4jY
         AcXw==
X-Gm-Message-State: APjAAAW1V1bfyBXtic3f8eKCglKZKCaDKeaiNEcA1fpB/bWT9ROEegd9
        NeKdzvucTO1vE9DfKzOxrL4=
X-Google-Smtp-Source: APXvYqx+mjnUeYOhiUHp2OSWra7c9gbT97jFl03WbbuCc21u9SPLAOw/T91dX4uBmrKfQ4lkwCj2og==
X-Received: by 2002:a17:90a:3225:: with SMTP id k34mr97679092pjb.31.1564160851038;
        Fri, 26 Jul 2019 10:07:31 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c130sm51664784pfc.184.2019.07.26.10.07.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 10:07:30 -0700 (PDT)
Date:   Fri, 26 Jul 2019 13:07:28 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     christian@brauner.io, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, dancol@google.com, tglx@linutronix.de,
        jannh@google.com, dhowells@redhat.com, mtk.manpages@gmail.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 2/2] tests: add pidfd poll tests
Message-ID: <20190726170728.GA157922@google.com>
References: <20190726162226.252750-1-surenb@google.com>
 <20190726162226.252750-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726162226.252750-2-surenb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> ---

> +		close(pidfd);
> +		// Wait for child to prevent zombies

Comment style should be /* */, but I think Christian would be kind enough to
fix that when he applies the patch so shouldn't need a resend.

Thanks Suren and Christian!

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

