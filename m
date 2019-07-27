Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 432D7777B8
	for <lists+linux-api@lfdr.de>; Sat, 27 Jul 2019 10:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfG0Il4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 27 Jul 2019 04:41:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40951 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfG0Il4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 27 Jul 2019 04:41:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so56674975wrl.7
        for <linux-api@vger.kernel.org>; Sat, 27 Jul 2019 01:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z2rEfKXA2wU0BCX6wIO81XssF9NHNexNhjvczm1Hm24=;
        b=YOLWpgMRTmnyFy6LILhQhyULRZ2a0FdiRGqIA0L40rGKsTxrgCetzxdISLU/Ijk88E
         aaJPIgyTjm3cwyIK0/2q348w2f94VVH+6qjRV/uE12JaHN2ziVWTfn0lzRh2iHrkbZtR
         viud4j+tRbWXIOBd0fMmgK6q+Optrftrp51dHotQWGuhfshyZmsjvGpDgUEyVp+jhe+g
         nfq/WZIlLZMhygNhHG1PyPHfgMb80hZ82c5qUMf6FoUrHvL3kQakRFp4moL5bmwyDsw1
         s2ppARphRhZV3449vqAygJnp4Pg/ztPaTb4ZTgqdu6s4dIqL9CRQ0dm0mcf3pMxjBRzf
         doUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z2rEfKXA2wU0BCX6wIO81XssF9NHNexNhjvczm1Hm24=;
        b=Eq/hIfY7q5tK0vjHdR8W2ig8ZFejEYNbpJ1WfogxBtt6vSnfuUKf394eTGzo8e085/
         fQ46SSmAJLbh+gwAG0fBK1kJZcSAkB2HIO3LuFM+zuTQ4vxUggSz0vB5HKwBjORHe1ry
         Lk7gcQgJ6LSZfkhazxeLXVkB3v6RVBZL+UPtGB3bNY4sNXHmUg1Vv9PyWA/KF0Q5rcej
         6hlTCPC+Q5/sswEG1cDYSEiB3hXtNCyDuDpy5TL0y+kk+nIrafCfCtrOyw76zgKEiDD7
         xzJEGxWRtEIdrJUTsH2i2Y6FiNdwWTUpu3v5nGLttDmVS277iGTqOOz1qkB0dS05ulYg
         P5HA==
X-Gm-Message-State: APjAAAWv94CjUqu77A7KJMjXgBDCFpuK+Qg4LV7UeeMTkPXDOtcR735H
        B3k/qElm7KjevQ62pgqCLEE=
X-Google-Smtp-Source: APXvYqwB44taN5fin7dHn1SqQBWQdk2XaixQ+GDNRg6axOnabQUbUTYNonfX0oHao6YkXHl6IfVFcw==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr17711619wrs.200.1564216913742;
        Sat, 27 Jul 2019 01:41:53 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id s10sm39638788wrt.49.2019.07.27.01.41.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 01:41:52 -0700 (PDT)
Date:   Sat, 27 Jul 2019 10:41:51 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, dancol@google.com,
        tglx@linutronix.de, jannh@google.com, dhowells@redhat.com,
        mtk.manpages@gmail.com, luto@kernel.org, akpm@linux-foundation.org,
        oleg@redhat.com, cyphar@cyphar.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 2/2] tests: add pidfd poll tests
Message-ID: <20190727084150.4wrbt2funusqqhqm@brauner.io>
References: <20190726162226.252750-1-surenb@google.com>
 <20190726162226.252750-2-surenb@google.com>
 <20190726170728.GA157922@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190726170728.GA157922@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 26, 2019 at 01:07:28PM -0400, Joel Fernandes wrote:
> On Fri, Jul 26, 2019 at 09:22:26AM -0700, Suren Baghdasaryan wrote:
> > This adds testing for polling on pidfd of a process being killed. Test runs
> > 10000 iterations by default to stress test pidfd polling functionality.
> > It accepts an optional command-line parameter to override the number or
> > iterations to run.
> > Specifically, it tests for:
> > - pidfd_open on a child process succeeds
> > - pidfd_send_signal on a child process succeeds
> > - polling on pidfd succeeds and returns exactly one event
> > - returned event is POLLIN
> > - event is received within 3 secs of the process being killed
> > 
> > 10000 iterations was chosen because of the race condition being tested
> > which is not consistently reproducible but usually is revealed after less
> > than 2000 iterations.
> > Reveals race fixed by commit b191d6491be6 ("pidfd: fix a poll race when setting exit_state")
> > 
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> 
> > +		close(pidfd);
> > +		// Wait for child to prevent zombies
> 
> Comment style should be /* */, but I think Christian would be kind enough to
> fix that when he applies the patch so shouldn't need a resend.

No, I will force you to resend this whole thing. :)
Jk, I'll replace the // when I apply it to my tree; no problem. :)

> 
> Thanks Suren and Christian!
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
