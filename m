Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFCE74B73
	for <lists+linux-api@lfdr.de>; Thu, 25 Jul 2019 12:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfGYKWA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Jul 2019 06:22:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40447 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfGYKV7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Jul 2019 06:21:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so49719998eds.7
        for <linux-api@vger.kernel.org>; Thu, 25 Jul 2019 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xg/jPeKKTB739DC4K1Kn5i6nMiOCPP3yYS7XnqJJUR0=;
        b=DZ2Ni7t05/jQ93QmmC1R/YHMhpDaH8fwuJhAj4qWCViaKIFm+SJfKoKs4xeUSlf6RS
         ailFXEETYnNGKz+7klPXoF8lDxcqG89449URMDPBWZjGELL7cSyACtnBbD4QDxEv4DoY
         Vn7vJM73S9XdMTu9iKTl/VdhHTOPfXZTu92TnJvcAWj+umf2IJhq27wK7ddcHkcgAu9y
         mqrSYlYtMqqPZ7K3fJP+EFG9XjL32ozVRHam37ox6u7p+F/nzOG6Vss7s/WlKrCfsT6W
         tjCKCSkaCnKbS7sl/aZOHoTqbO5jqslxO5EDaNiyel8F4szFy3JP3f0qL8zonVM1mpTl
         2dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xg/jPeKKTB739DC4K1Kn5i6nMiOCPP3yYS7XnqJJUR0=;
        b=rxs+GQEJ9GBcyQ1JsQiORusJbkZePCQvb22ODeYGzXc+9TGcieNKYdjcu7haNaV6K0
         G4TAa0d7dsMovxP3syPSKNzPMFws7HZOYjUrbV97PED0qMCgp2NK5w8gb6KMypqDfeh7
         jnxpM1Jkk/cXRDB/qD+VhbDRzAvae0E4afXvpX/0RjEuRM5b0YYjviXQja/RaBnK3kZS
         ktz9aKiHmCdDV1AzbVbUXxuiNBxqsklbSMqBdboiITughzwrmgrfOoAzW0huLxt45usB
         pdan/Fz7LcZVaYXIRkxDVYEn9TGuz9qWCYUXOv6MO1F9sd4S7rfx52BmElsxk6RvqKU0
         m8mQ==
X-Gm-Message-State: APjAAAV1KatBjKSuAnyi48QgIxAov4H4AZFUJAbhNf7nOS2+pQKS26Ev
        k9JKp0UO0IiKcG7KJOGMCn0=
X-Google-Smtp-Source: APXvYqwnnlwEsNrhcUAHrNjHscYNwb1YbvHUcf+02n2cfVtguvWwOau6+5+iaL+tXi5yG6SvDguEKg==
X-Received: by 2002:a50:ad45:: with SMTP id z5mr75231854edc.21.1564050117987;
        Thu, 25 Jul 2019 03:21:57 -0700 (PDT)
Received: from brauner.io (ip5b40f7ec.dynamic.kabel-deutschland.de. [91.64.247.236])
        by smtp.gmail.com with ESMTPSA id uz27sm9729326ejb.24.2019.07.25.03.21.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:21:57 -0700 (PDT)
Date:   Thu, 25 Jul 2019 12:21:56 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, linux-api@vger.kernel.org
Subject: Re: [PATCH 2/5] pidfd: add pidfd_wait()
Message-ID: <20190725102156.nqnngsrb6dwmyztb@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-3-christian@brauner.io>
 <20190725101626.GD4707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190725101626.GD4707@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 25, 2019 at 12:16:27PM +0200, Oleg Nesterov wrote:
> On 07/24, Christian Brauner wrote:
> >
> > +SYSCALL_DEFINE6(pidfd_wait, int, pidfd, int __user *, stat_addr,
> > +		siginfo_t __user *, info, struct rusage __user *, ru,
> > +		unsigned int, states, unsigned int, flags)
> > +{
> 
> Oh, I too think that P_PIDFD makes more sense.

I have already updated the patch to introduce P_PIDFD.

> 
> and could you explain in the changelog why? I am not arguing and if
> nothing else this is consistent with other pidfd features, but if you
> are parent/debugger you can't hit the problem with pid-reuse, unless
> you races with your sub-threads.

One of the things is that later on this will allow us to make it
possible to retrieve the exit status via waitid(P_PIDFD) for non-parent
processes if handed a _suitable_ pidfd that has this feature set. Maybe
even - if safe - make it possible to wait on a process as a non-parent.
And some tools just really want to do away with pids completely.

Christian
