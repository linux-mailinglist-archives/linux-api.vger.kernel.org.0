Return-Path: <linux-api+bounces-3186-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2641AA31247
	for <lists+linux-api@lfdr.de>; Tue, 11 Feb 2025 18:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE747163BC3
	for <lists+linux-api@lfdr.de>; Tue, 11 Feb 2025 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E9F26139F;
	Tue, 11 Feb 2025 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJEeZBJl"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9D260A29
	for <linux-api@vger.kernel.org>; Tue, 11 Feb 2025 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293235; cv=none; b=n/0FEFcUvKEwOMXt9AAaQERsl/rcR8F6Ogv6zH/vHEuJ5Xmvvvg9a2w5CAuNiWLDt2jK/thucgMA1TRp8ipq7ZttqmbSNXrF3dSjOhcRS3PjHsfjKYwZoWfyAlHSsjoFUptl7/I/1kc3w5xGgOaHeiMMzhB6tCh/F0MMq3LvWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293235; c=relaxed/simple;
	bh=Ijl1870gwz6IX+/MESbsYzIdZlpRJGmSg/J77w9i4U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZCK3M3h4nRxgWegzAAsLzs7iSFXiB80A6fMv+0EcIlNKWyVSj1yogKMa4Mdx5Z77loH9ETFjsbxSCOXcJW9mMrhoNF0Wnc6b4uFx9gSqqTyz8KT3BxnAwqjHAr8A7wxHl+OK/fTO/Yq0fU4wk2Hi2mvyzXOG8Py/AFDII1Ulqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJEeZBJl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739293233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ijl1870gwz6IX+/MESbsYzIdZlpRJGmSg/J77w9i4U4=;
	b=gJEeZBJlRP9T2mgDzXkOfToTk0lBBUP0fPNnC2TKzkC5DMuX6RhU6tzJdme/ZYzkz804jI
	FE4h70UhzNfRCFR1f8axcg2Ol2iIWLUbpZff80U+eXoVzliXRbgxKZ9mAN2md1S/+zuOdY
	jqfMTtMrHClEPM8KzT0Nt+jS49qfA/4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-DUCuPesZNGyoR9XuI7pEIQ-1; Tue,
 11 Feb 2025 12:00:29 -0500
X-MC-Unique: DUCuPesZNGyoR9XuI7pEIQ-1
X-Mimecast-MFC-AGG-ID: DUCuPesZNGyoR9XuI7pEIQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D32C91800872;
	Tue, 11 Feb 2025 17:00:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5438019560A3;
	Tue, 11 Feb 2025 17:00:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 11 Feb 2025 17:59:51 +0100 (CET)
Date: Tue, 11 Feb 2025 17:59:41 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	stable <stable@vger.kernel.org>, Jann Horn <jannh@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>,
	bpf <bpf@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCHv2 perf/core] uprobes: Harden uretprobe syscall trampoline
 check
Message-ID: <20250211165940.GB9174@redhat.com>
References: <20250211111559.2984778-1-jolsa@kernel.org>
 <CAEf4BzYPmtUirnO3Bp+3F3d4++4ttL_MZAG+yGcTTKTRK2X2vw@mail.gmail.com>
 <CAADnVQJ05xkXw+c_T1qB+ECUqO5sJxDVJ3bypjS3KSQCTJb-1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ05xkXw+c_T1qB+ECUqO5sJxDVJ3bypjS3KSQCTJb-1g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 02/11, Alexei Starovoitov wrote:
>
> > > +#define UPROBE_NO_TRAMPOLINE_VADDR ((unsigned long)-1)
>
> If you respin anyway maybe use ~0UL instead?
> In the above and in
> uprobe_get_trampoline_vaddr(),
> since
>
> unsigned long trampoline_vaddr = -1;

... or -1ul in both cases.

I agree, UPROBE_NO_TRAMPOLINE_VADDR has a single user, looks
a bit strange...

Oleg.


