Return-Path: <linux-api+bounces-1514-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019828C6577
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2024 13:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CF31C21BBC
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2024 11:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479C874432;
	Wed, 15 May 2024 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKLSLYPI"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8876058
	for <linux-api@vger.kernel.org>; Wed, 15 May 2024 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715772068; cv=none; b=PUwwuE2IVDYCGbFm9gl1GDEFZ0iNfzOJfEuZcGrtKR0Dk4j5WY9Q1HnZSScIfHvVIk90sioEslI/jHjX5iCaYiVEPKRCVLcSD1n6vOjynmvOyc5mrG2X8JiRmZy5MGtJeAbpYAlPbWq3464uusdFU0i4UthEeGeI0BUBjvjzElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715772068; c=relaxed/simple;
	bh=M/ZccXoJRnPbA6meUj/MmsF/JxN6cGeMpuCaH9Cj9bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MV+eZfQ3+k7/nS6CGej63JsBBUXwNIpN7fIEAK+8J/cbCapxl/jS3piWty+4+txU+Zvq1vh/DSo7kmaR9nPLNR979n+BDhhejKD1Shf6RoVJPy1F6ngXsYWWb3K/B+49ZLkPVYxejgbD2fwM9G5PcrkYvCd+S2Mfp9zzeuMM9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKLSLYPI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715772065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5bDd9jfqFy8/uy57c7rT9ALmyU6BJ6GsFfTS9tK9yg=;
	b=WKLSLYPIVNx9BPfTU2gMFWDkwlzIrJ6JdqAOEg8rvhzwffgTk2eFit2H36jubhEzcJ0WIQ
	BkVnS6mpP7134O4JHicKaNOyDuFKN0cXKsmgsv6N4IoErowok/V/W3wxBU771u1nMOiKD6
	yNO2p/dxtr9jFmc5vkYPWZzXPB9gGP8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-WhGl7FHGPIyWXZjzT2JL7g-1; Wed, 15 May 2024 07:20:54 -0400
X-MC-Unique: WhGl7FHGPIyWXZjzT2JL7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 415FA8058D7;
	Wed, 15 May 2024 11:20:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.36])
	by smtp.corp.redhat.com (Postfix) with SMTP id 26913200A08E;
	Wed, 15 May 2024 11:20:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 May 2024 13:19:26 +0200 (CEST)
Date: Wed, 15 May 2024 13:19:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"olsajiri@gmail.com" <olsajiri@gmail.com>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"yhs@fb.com" <yhs@fb.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Message-ID: <20240515111919.GA6821@redhat.com>
References: <20240507105321.71524-7-jolsa@kernel.org>
 <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
 <ZjyJsl_u_FmYHrki@krava>
 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
 <Zj_enIB_J6pGJ6Nu@krava>
 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
 <ZkKE3qT1X_Jirb92@krava>
 <3e15152888d543d2ee4e5a1d75298c80aa946659.camel@intel.com>
 <ZkQTgQ3aKU4MAjPu@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkQTgQ3aKU4MAjPu@debug.ba.rivosinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Sorry for the late reply, I was on PTO.

On 05/14, Deepak Gupta wrote:
>
> Question,
>
> Is it kernel who is maintaining all return probes, meaning original return addresses
> are saved in kernel data structures on per task basis.

Yes. task_struct->utask->return_instances

See prepare_uretprobe() which inserts the new return_instance with
->orig_ret_vaddr = original return addresses
when the tracee enters the ret-probed function.

> Once uretprobe did its job then
> its kernel who is ensuring return to original return address ?

Yes. See instruction_pointer_set(regs, ri->orig_ret_vaddr) in
handle_trampoline().



I know absolutely nothing about the shadow stacks, trying to read
Documentation/arch/x86/shstk.rst but it doesn't tell me too much...
Where can I find more documentation? I didn't try to google yet.

	Upon function return, the processor pops the shadow stack copy
	and compares it to the normal stack copy. If the two differ, the
	processor raises a control-protection fault.

grep-grep-grep... exc_control_protection I guess.

Let me ask a couple of really stupid questions. What if the shadow stack
is "shorter" than the normal stack? I mean,

	enable_shstk()
	{
		prctl(ARCH_SHSTK_SHSTK);
	}

what happens when enable_shstk() returns?


And what is the purpose of fpregs_lock_and_load() ? Why do we need to
fpregs_restore_userregs() in shstk_setup() and other places?

Oleg.


