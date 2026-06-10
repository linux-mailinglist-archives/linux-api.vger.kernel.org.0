Return-Path: <linux-api+bounces-6598-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vpgqMrz2KWrUgAMAu9opvQ
	(envelope-from <linux-api+bounces-6598-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2026 01:43:56 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 446A266D6A5
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2026 01:43:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=slxb3N4b;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6598-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6598-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41A55303B7C1
	for <lists+linux-api@lfdr.de>; Wed, 10 Jun 2026 23:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1AF390613;
	Wed, 10 Jun 2026 23:41:07 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2648D38E8A7
	for <linux-api@vger.kernel.org>; Wed, 10 Jun 2026 23:41:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781134866; cv=none; b=fegk3YgONDCqQ3/UG5OxRQl2itcOPHROhcruwqp5YJzlkKJnrS2f5LLmFA07JvLWow20IKjij6EmUNoiqoYF+sHulPgeICu8jMZMfAoedIt3Uknh/7B3mnZCCx562WlLPO9MNrFnkH8mkYgTQySMa5knVB3mM4ecFb/1s6cW3DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781134866; c=relaxed/simple;
	bh=WLKFSvoHBAuURbkH0azFPoXH0iTJec2iRBnKyq7YHT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f51lwzHc9LppMbKupguzaBx3pKN9rcPE8s/GzHVwVgRcbAAhkrt2/cOkcCogrj1GQF/hAQVLwPPIEjVbk34FP3rXXuaml9xtn7B9sbwNuwvpaj4EvXiwiuQMlP/ui4ElJ51oBD6GIUqvHMe6ZsBQAr6B7XG18yyMfJgRU7fIRdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slxb3N4b; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso2607485e9.0
        for <linux-api@vger.kernel.org>; Wed, 10 Jun 2026 16:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781134863; x=1781739663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hItbBwzE/UemJbPm5Fn7DOlYpjoWK0GBfBYmIwvZBe8=;
        b=slxb3N4bFW1Qs3memInulsiDuICRh2Zf9ZsFSF1rVQ6FbolbwDG06y5HMYqDQ+mfpH
         Q3a9n74hereuyEvM9iVcgruLRnEeLYlPWIqVTVTkbFQ83+4U1mr2LyFN2OisN60VIRIu
         VM06mzir7DHgGFkA1iRFyBHcrQPA3uBO4eajSfqiPHW/4rHOAioxIjoY1GJYYpI3LIGx
         7FJFGIL25t2kEN0M90zrhuPf0rbhPVcfcH8Zb4DMekwwgReCijPDrG+wpiTPk2P4G9A5
         28Py06VePTd2y10Rzca9UJfwv+h/fcBSHPRqr/cr1XhGgvGW3dfrV2xLYomD/lFwAyxl
         wnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781134863; x=1781739663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hItbBwzE/UemJbPm5Fn7DOlYpjoWK0GBfBYmIwvZBe8=;
        b=NaO+3+Df/4rc5jzuOIt827hnwDdx11im5NWsgK9ZLLADLWemQKTVWbvy3IHpnOkOpE
         JKQYvDM7P5BoMYhgqm7y6kv8M8Hisd5P0urZZLgA6slJ4UsCbdrzOLIlD8lBv50A3TAe
         n5GBRK8+nAQ+g9QFuB7Zh3jpGNEvVjhlJOU+VFe2f8OhdpM+LJZNXIB8n4fTjx5MK5E2
         tJdAe/YgQql6ia+FZU5NOggcXxcGludj4dOfNhhmxjXOqHwTvlIoRkLo2K8MLw8JaLXw
         Zq4V9geiiuMjDJETfS3MDWOomhDCV7kBKAecb16omWqLUio3j6Zlk/FToCeSVmCPXs2j
         Ffyg==
X-Forwarded-Encrypted: i=1; AFNElJ8BzlbqDRZ6tNJPW69MjvedCc1eSQ9jJJmyFhvTvQ1ut7sa6JFayW+j5UcafLfvCWm8bm/EIh/P+sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKfYMeRfnamgzTcyAm2eR2YL9rCb56e2FQqwJeg/7jCRVIZ4R
	Cc7nhmMvvW9Pzx0FkorMdxcb4u5a7xfWiylTLu7fY4C11qBeVuvTVZln
X-Gm-Gg: Acq92OF6vUxJwye+2WBkDXLpu/ZHCqjnYa6GV07JHFA3KeLlCojWGiNztUWP6P5GKe+
	rgezpTojbWbCH/ko4k6RsN1ibptSTGdiWootytJQWIq6q/P6CVJTfAY9LBHLl6dIKd2qhiHVRI/
	mS6S7t4BMnxqLnu6KXYjXcKw18qnWolCNwjNxFI1JRypaTtJWB1VyOs6ZhwzXcCVYiHannIb9Ux
	U8GQt76w2/Xy3ozTWyG9zG2W7Qq3anWHB9NHfZ7oo5EQZSTNFceSzULN/qq1Kj58PAqqrXaBi+r
	B5Iam5ljF8JOdECBP3ntHvt+4OwU3oYoK0gt6PqdEKVbgp8zTAuoe+qgPlqKPPMRY7r7wp6nq+F
	mnuvrZB93JPBlR2ugzQke8eOSHOlflg0+ng9V3inYNENGJzUE1hbwtB3GjbNsLe3f5aq8e3dJFS
	1FSk1YEyefOjYTKAcsIRe5a+hNprkmhPjCi0TBs+6fw4W2OZGpo9ZZZrN57uR7qAfPVn/i4i6+W
	AcIt0MsKg==
X-Received: by 2002:a05:600c:1554:b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-490e5318363mr872135e9.15.1781134863322;
        Wed, 10 Jun 2026 16:41:03 -0700 (PDT)
Received: from f (cst-prg-85-110.cust.vodafone.cz. [46.135.85.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e422e321sm4497435e9.0.2026.06.10.16.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:41:02 -0700 (PDT)
Date: Thu, 11 Jun 2026 01:40:56 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Li Chen <me@linux.beauty>
Cc: John Ericson <mail@johnericson.me>, Andy Lutomirski <luto@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	linux-arch <linux-arch@vger.kernel.org>, linux-doc <linux-doc@vger.kernel.org>, 
	linux-kselftest <linux-kselftest@vger.kernel.org>, x86 <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
Message-ID: <hd3i6pxxohsjesyid7nhuic6ppp6nyoxxpwa4mny6riqvpyqec@mylfprni2yaw>
References: <20260528095235.2491226-1-me@linux.beauty>
 <20260528-madig-fachrichtung-fehlinformation-61117ba640da@brauner>
 <CALCETrWJQpLR4n1cpichBk8=uExSKLWTMGU3BufGdk_WE_p5UA@mail.gmail.com>
 <19eacd64508.26b92c022125848.262962729296162879@linux.beauty>
 <4e049396-377d-48a7-a34c-91318413a876@app.fastmail.com>
 <19eb181fdd4.6d028f442844776.3737831021032223216@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19eb181fdd4.6d028f442844776.3737831021032223216@linux.beauty>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-6598-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mjguzik@gmail.com,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:me@linux.beauty,m:mail@johnericson.me,m:luto@kernel.org,m:brauner@kernel.org,m:kees@kernel.org,m:viro@zeniv.linux.org.uk,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-arch@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:x86@kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 446A266D6A5

On Wed, Jun 10, 2026 at 08:29:06PM +0800, Li Chen wrote:
>  ---- On Wed, 10 Jun 2026 01:27:47 +0800  John Ericson <mail@johnericson.me> wrote --- 
>  > Hope the above answers your question? I suppose my ideas lean more on the
>  > "future" than "empty" side --- there is indeed a thread in the thread group,
>  > with real VM/namespace/file descriptor etc. state. Moreover, state gets
>  > initialized before the process is started, so the actual start is a pretty
>  > lightweight step of just letting the scheduler know the now-ready process can
>  > be scheduled. The only thing that distinguishes the embryonic process from a
>  > real one is simply that it isn't running --- i.e. isn't (yet) available to be
>  > scheduled --- so the pidfds holders are free to poke at its state.
>  > 
> 
> Thanks, this helped a lot. I looked at FreeBSD/OpenBSD/XNU after your
> note. FreeBSD has P_INEXEC, OpenBSD has PS_INEXEC, and XNU seems even
> closer with P_LINTRANSIT, described as "process in exec or in creation".
> Linux does not seem to have a single equivalent today: current->in_execve
> is only an LSM hint, while the real synchronization is spread across
> exec_update_lock, cred_guard_mutex, and the exec path.
> 
> I am switching my local WIP from the two-fd builder model to one fd,
> closer to Christian's sketch:
> 
> fd = pidfd_open(0, PIDFD_EMPTY);
> pidfd_config(fd, ...);
> pidfd_spawn_run(fd, ...);
> 
> In my current local version, I still use copy_process(), so the fd points
> at a real task_struct/pid that is not woken until run. Following
> Christian's point that existing APIs can handle this not-yet-running case
> with ESRCH, I currently make ordinary pidfd operations that need a real
> started process return -ESRCH before start.
> 
> I am not sure yet whether Linux should grow a general exec/creation
> transition state like that, or whether a narrower future-process
> lifecycle is enough for this API. I will think more about that when
> working on the pristine process version.
> 

As I tried to explain in my previous e-mail this approach does not cut
it because of NUMA.

Suppose you have a machine with 2 nodes. The parent-to-be is running
on node 0 and the child is intended to exec something on node 1.

When the parent-to-be allocates and populates stuff, it takes place with
memory backed by node 0. If you allocate task_struct, the file table and
other frequently used (and modified!) objs in this way, you are
guaranteeing performance loss due to interconnect traffic to access it.

Trying to add plumbing so that all allocations respect numa placement is
probably too cumbersome.

The primary example for that is looking up the binary to exec in the
first place.

userspace likes to pass paths which don't exist, meaning checking for
the binary before any hard work is a useful optimizaiton. Suppose the
binary to be executed is in a container bound with a taskset using
node 1 and the content of the fs part of the container is currently
fully uncached.

When you perform the lookup on node 0, you are populating a bunch of
metadata (inode, dentry) using memory from that domain. But the intended
user will only execute on node 1, again resulting in a performance loss.

In order to not do it you would need to convince VFS to allocate memory
elsewhere.

So I stand by my previous claim that ultimately a pristine child has to
be created (like in this patch), but which also has to do the work on
its own.

Suppose there is no explicit placement requested anywhere. Even in that
case there are legitimate workloads which will eventually be forced to
exec stuff on another node. Even these have a better chance retaining
full locality if the child process does all the work.

Per my previous message I don't see a clean interface to do it.
something quasi-posix_spawn is probably the least bad way out, it will
also allow userspace to easily wrap the new thing with posix_spawn
itself.

Also note there is another issue with the fd-based approach: the fd will
get inherited on fork and will hang out in the child afterwards unless
explicitly closed. Suppose you have a multithreaded program which likes
to both fork(+no exec) and fork+exec. With the fd-based approach you
have no means of stopping another thread from grabbing your state thanks
to unix defaulting to copying everything. There was an attempt to fix
this aspect with O_CLOFORK, but this got rejected.

Whatever exactly happens, NUMA is a sad fact of computing and needs to
be accounted for. The approach as proposed not only does not do it, but
it actively hinders such deployments.

