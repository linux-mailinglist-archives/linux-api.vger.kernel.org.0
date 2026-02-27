Return-Path: <linux-api+bounces-5887-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFbuBjIComnPyAQAu9opvQ
	(envelope-from <linux-api+bounces-5887-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 27 Feb 2026 21:44:34 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD051BDE4F
	for <lists+linux-api@lfdr.de>; Fri, 27 Feb 2026 21:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DA5C30ECBC1
	for <lists+linux-api@lfdr.de>; Fri, 27 Feb 2026 20:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E02E477E41;
	Fri, 27 Feb 2026 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhspo+Wb"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BFC477E2F
	for <linux-api@vger.kernel.org>; Fri, 27 Feb 2026 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224917; cv=pass; b=bkdKCZEpIhUBFygkt1MklMvsaZA9vNE/+KrNhPz9j85sovfvrciuQTQvL7H08tfH9JqNRmLSpd7syK6XkHzUDjRvEIW9PeA2Kl7UIWwMCgTonckWbLrkPIjgPev4F2q8nSdpRyF/H554egj4pxhxd6WLuJl/hHAZpQXAa0M6Xl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224917; c=relaxed/simple;
	bh=ukyBeXYWyJu7f1Yx4e8NLQfbaNh83o4PbWmuds8sltw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+cJqSfuDOwMoU23c9GpB10xWNQxsfxFJXlpAo4EdIAhEob8cVdSEcnRnk55GB91QFRvgg5lBNtRfm4opUgEBvc2bE8D1cJTrLiTG/Tax57oGJy5DV5fGeVVXB9jWZMN2uK09UvJz51kYvsp/5nD1yswiRdJIPYm8bG2IQfl3Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhspo+Wb; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506a355aedfso93801cf.0
        for <linux-api@vger.kernel.org>; Fri, 27 Feb 2026 12:41:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772224915; cv=none;
        d=google.com; s=arc-20240605;
        b=DJB2MeefhlQkAOqdPV4+/cp89o4jTrS2qRa+8F9J7iy1Pscjf6eoEFatjw+oxfjjWv
         LRRRID3H+vxSPJi8anYRkWekI8o3cpuD0WmawCbB52zNB5W599d2SehdBBGysh6wrUTO
         IR+cdJK/bKBXL9C0o9vmPCozy47xQOLc5TW3RbEyp9aGNbClhdXpZrYsuYd/OshIQhSe
         PDqjhV84+OxMTXSJnK6rtCFciG4kjcnTtxSFSDbTTwwj4j4LuixHb0iT5esVCiX8I8YA
         +ZeiMLoQhUyxGLHpuiYrNDM9FTNMhBpgdJo4lVTP5rT0UNPeT6BXNSurLReBg/HBW9w9
         hvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/U74nNxDCECL/I/RN1dMT3/oLzyOBAubJj5O2PoQW5c=;
        fh=H9bhpy7h6yga1lzDCyInKwxXA4DvaIJj64Ii7WB7UR4=;
        b=Op8UjI7UZ1i3qx42I7itKj8L2hpv5t7Y+MWj0/X6tERnEuZMjDjF/+n04ZflWz6G7n
         Xz91NGSxhh+LQYTl6bzzwqxhtVvRy1bHSa+EHfkGuhxL7LecwWY3ag44W8bxs0QOuMgP
         F9nYR/n401ZimT6Uib7tXmTOTQfQAE8NqlGETMGLrj5Ooif5ksmcSdNI00zo4Eh2AOIS
         6mY8qj/TcYk+uLTQZa3zCS3UpRmAH9dON9yMqYJVXFNtRjpSx7EXh/S/rruWcs5wGDJi
         wgJGt4pEVWQ3+s445R2a9RiYuOc/UlaoE4xbW/N8wQy9EUBDpAv41CQ0wVgDZuKZYitL
         tlzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772224915; x=1772829715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/U74nNxDCECL/I/RN1dMT3/oLzyOBAubJj5O2PoQW5c=;
        b=qhspo+WbIDKcWgtI2hzc2So0cZ5KLFLKwvbaK7sCtOX0e455HrCycsYgHbLpwo7b0a
         8Uf9DyY9BVCiDs+osUn86C8tBoNPs4ezOTnGYt07v3OMi2TzKGixj3wlvr6XzMxA4XS1
         eLqliLgqwsHrd3r0+Oh/MGYWdugot+2Yb67LSAvX8adZ0MiYdzglHY0UTby+8MmidRbf
         x6qKlBTAlT5fgNmmYlYvjCXNSzIe1ac3pybI6ATJQ0B2hfgs+kLq3HRzea5Gcg45nbkG
         vdw4aiMN0tN44PZF6aBVBV7nYUYqFkLgjq1L6wnDLQ5ntFpFUnEyXOll/RLrIasCP5XB
         MeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772224915; x=1772829715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/U74nNxDCECL/I/RN1dMT3/oLzyOBAubJj5O2PoQW5c=;
        b=KNVp03RVBjR2OEPv2QO2JNUu3lVZc6ZFQdHwl64gm/no9hIvzbZs0aWeXjCM3rKnTV
         j6Hi2WmP6FAHVuSYwwWABMsQWSfo9m8Jz3DMBfIYWRPRd+709RpeGKN/gsXAfXUeASGA
         X2NQpucDR09FhylviFXVoam0CFHL93MpXugohMMKZ8dSYk8tueiOyVszsaGJWstxDY/t
         pup7kmIFH06WVYVQ+DZhL6FW4CMEIB0YB4KfIBwJoT3FvUS9HcDj1TKI4JumIbXCyv3D
         AJesgypP9+tMYY6JgG/vd9jiuVn6I/VMx3MXlzjZ8D4R0qmPtDhPwDpEGEAEKz+CeLuu
         NqxA==
X-Forwarded-Encrypted: i=1; AJvYcCVeJD9Ukx4z87tifztIGsP7L2xPV7uoVOLMTkX0vxhU0RSHUnMHL9k2tTE9CvrPBhppWiOSxrOBvOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw470TiTjfek6vAzOzwqtly6lsSmdwLLanoxX+BLZINTwQaohS
	o91YdFPfkWZSZcOa/dznL2x2zVHQMIHbod/sM70jZnL7YbksgoYhbl1uO2Y/E7PI0wo6m9x4D0d
	blJ1H8lK6AL0owoWcJVHwB3BDdg0yDWZi2MR39IYI
X-Gm-Gg: ATEYQzyXFVf+y2cY1EotZSyLHEwOX7iEz6J8VJiyhglsJD5Do7emqPZyzJdYQWp7hlj
	uYEcIutlrqOiqp5EXT5Opx6B65ptGC3rOmyvcCazYNhKjgWUQENK3wTfxBPOKYjPkYc7DHCJGZd
	4aZHDwutc1OfhCZMD0NopjYYAXgctFCuknBx4pL4B7g3na+eabrnYZOgEMJx0gy/n8nH9u9T1S3
	MA7LgpfX3F8dO0VRUkzpQF5Zo1LJgX5Fk6OaaAAHymLHynds2qa730R3UeARWtNeVC1F8H0v0JJ
	EIdQ7WfAvEGRZufaLMoTv1pET7hucXq4rao=
X-Received: by 2002:ac8:5807:0:b0:505:e719:3b49 with SMTP id
 d75a77b69052e-5075ff50725mr1922411cf.11.1772224914578; Fri, 27 Feb 2026
 12:41:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220202620.139584-1-andrealmeid@igalia.com>
 <0d334517-63ee-46c9-884d-6c2ae8388b87@efficios.com> <67be0aa1-2241-43ef-aa01-a89ced26c8f6@efficios.com>
 <a1e24288-6ffc-438d-8a2a-d152134c9555@efficios.com> <ed918547-1406-4ae6-8a94-4e03712a4923@igalia.com>
 <bd7a8dd3-8dee-4886-abe6-bdda25fe4a0d@efficios.com>
In-Reply-To: <bd7a8dd3-8dee-4886-abe6-bdda25fe4a0d@efficios.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 27 Feb 2026 20:41:43 +0000
X-Gm-Features: AaiRm50baMVnF8_iUGWsOlCYCRaD-NOiyRPc2l7wjCI_E5VTEqRV62ZfSJe5hts
Message-ID: <CAJuCfpEXoH1Ek1Nkg0s2jPm4SJ+mU1adUAu2NqyVH18skye2sA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] futex: how to solve the robust_list race condition?
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	kernel-dev@igalia.com, "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-api@vger.kernel.org, 
	Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>, 
	Torvald Riegel <triegel@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rich Felker <dalias@aerifal.cx>, 
	"Carlos O'Donell" <carlos@redhat.com>, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, 
	libc-alpha <libc-alpha@sourceware.org>, Arnd Bergmann <arnd@arndb.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, npache@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-5887-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[efficios.com:url,efficios.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6FD051BDE4F
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 8:00=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2026-02-27 14:16, Andr=C3=A9 Almeida wrote:
> [...]
> >> Trying to find a backward compatible way to solve this may be tricky.
> >> Here is one possible approach I have in mind: Introduce a new syscall,
> >> e.g. sys_cleanup_robust_list(void *addr)
> >>
> >> This system call would be invoked on pthread_mutex_destroy(3) of
> >> robust mutexes, and do the following:
> >>
> >> - Calculate the offset of @addr within its mapping,
> >> - Iterate on all processes which map the backing store which contain
> >>    the lock address @addr.
> >>    - Iterate on each thread sibling within each of those processes,
> >>      - If the thread has a robust list, and its list_op_pending points
> >>        to the same offset within the backing store mapping, clear the
> >>        list_op_pending pointer.
> >>
> >> The overhead would be added specifically to pthread_mutex_destroy(3),
> >> and only for robust mutexes.
> >>
> >> Thoughts ?
> >>
> [...]
> >
> > About the system call, we would call sys_cleanup_robust_list() before
> > freeing/unmapping the robust mutex. To guarantee that we check every
> > process that shares the memory region, would we need to check *every*
> > single process? I don't think there's a way find a way to find such map=
s
> > without checking them all.
>
> We should be able to do it with just an iteration on the struct address_s=
pace
> reverse mapping (list of vma which map the shared mapping).
>
> AFAIU we'd want to get the struct address_space associated with the
> __user pointer, then, while holding i_mmap_lock_read(mapping), iterate
> on its reverse mapping (i_mmap field) with vma_interval_tree_foreach. We
> can get each mm_struct through vma->vm_mm.
>
> We'd want to do most of this in a kthread and use other mm_struct through
> use_mm().
>
> For each mm_struct, we go through the owner field to get the thread
> group leader, and iterate on all thread siblings (for_each_thread).
>
> For each of those threads, we'd want to clear the list_op_pending
> if it matches the offset of @addr within the mapping. I suspect we'd
> want to clear that userspace pointer with a futex_atomic_cmpxchg_inatomic
> which only clears the pointer if the old value match the one we expect.

I've been looking into this problem this week and IIUC Nico Pache
pursued this direction at some point (see [1]). I'm CC'ing him to
share his experience.
FYI, the link also contains an interesting discussion between Thomas
and Michal about difficulty of identifying all the VMAs possibly
involved in the lock chain and some technical challenges.

[1] https://lore.kernel.org/all/bd61369c-ef50-2eb4-2cca-91422fbfa328@redhat=
.com/

Thanks,
Suren.

>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>

