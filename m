Return-Path: <linux-api+bounces-583-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BAF839C09
	for <lists+linux-api@lfdr.de>; Tue, 23 Jan 2024 23:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA281C25122
	for <lists+linux-api@lfdr.de>; Tue, 23 Jan 2024 22:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA244F1F2;
	Tue, 23 Jan 2024 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqRVvJRi"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F596525B
	for <linux-api@vger.kernel.org>; Tue, 23 Jan 2024 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048633; cv=none; b=f//B93ipXBbAF1yEr5tjic6BMPd2XcdZu+2kGSQkBx11maSHF4eIBKPbD6K5QYDVubO7KuNdVsUyivS/Or1TuaaZTogYb+IejUgQrd7Tr2zsuJoIJ0uuut3sztyx24wg6xaJLtqD3I2D9cd9pY41R7S5K85h93sKEAEr444xfIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048633; c=relaxed/simple;
	bh=2qeiv2f0Rnl56+1ZOayTWh56YtuPy1oK2jgNwHECTgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSRfEUD7dEa8IHZyrNNKLuo8HdtvsvpRxyw/r6OiB4Dj8yirHI/ND1K0pjRWuDj5BqIutqm5oCByhdpZ7d8TqI74xh5zni6w8MXmgzqxedZgBkaCStn+tgIvGE0e835TabhgP1sB88ZhJWcGv1udL7VVxia9oOVVJAtqZsjVixg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqRVvJRi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706048631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QRtv6MwGFAiCHrTTIDTaoBSr2kODb8F3izG+iIcZ5ik=;
	b=BqRVvJRiiG3Qb7aATuNs8af+0XgRBuKDXEnCPVOw+15KzwFGVfNWHR/5oJQHCPMBqTjZJV
	Hlg4MPkiqJQUuAJs4fSECE7MnPQjCQcXdF6Vz3NY+Q35rba8MGlaaUzyz4i3wXs8yzDd3m
	Xhy3OFxf8xsIxofLo53jKRu+6nvlwFQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-1l936kqxOMambpdCa9tscA-1; Tue, 23 Jan 2024 17:23:47 -0500
X-MC-Unique: 1l936kqxOMambpdCa9tscA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C4BC85A596;
	Tue, 23 Jan 2024 22:23:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.197])
	by smtp.corp.redhat.com (Postfix) with SMTP id C5A6540D1B60;
	Tue, 23 Jan 2024 22:23:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 23 Jan 2024 23:22:34 +0100 (CET)
Date: Tue, 23 Jan 2024 23:22:31 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240123222231.GA25162@redhat.com>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbArN3EYRfhrNs3o@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

I am already sleeping. I'll try to reply to other parts of your email
tomorrow but I am not sure, I will be very busy with family duties.

On 01/23, Tycho Andersen wrote:
>
> > >  	__exit_signal(p);
> >
> > and,  do_notify_pidfd() is called before __exit_signal() which does
> > __unhash_process() -> detach_pid(PIDTYPE_PID).
> >
> > Doesn't this mean that pidfd_poll() can hang? thread_group_exited()
> > won't return true after do_notify_pidfd() above, not to mention that
> > thread_group_empty() is not possible if !thread_group_leader().
>
> I was wondering about this too, but the test_non_tgl_poll_exit test in
> the next patch tests exactly this and works as expected.

Well, if release_task() completes __exit_signal() before the woken task
does thread_group_exited(), pid_task(PIDTYPE_PID) will return 0 and
pidfd_poll() won't hang.

But to be honest I can't understand test_non_tgl_poll_exit() at all. I don't
even understand why the process/thread created by fork_task_with_thread()
should ever exit. And why it creates the "writer" child... Never mind, too
late for me to read the code.

Oleg.


