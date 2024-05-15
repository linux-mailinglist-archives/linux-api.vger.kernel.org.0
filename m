Return-Path: <linux-api+bounces-1519-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C96518C69A9
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2024 17:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F34B283275
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2024 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A0A155A2F;
	Wed, 15 May 2024 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCMoy79y"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D45155A26
	for <linux-api@vger.kernel.org>; Wed, 15 May 2024 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786887; cv=none; b=TP1tnUqNJk7jG07PvyFNpWEuKz2kIZehMHwxSt9q+KCNnQw66Y/joRX05c+NE4am2K0EgGEVWTjbk4EsDPGywAmjVdkqInLYQjirUjmHDIfbS76xBxtAsDV3m7Wb37jcLFJrd5wQID2AUSBo9icuBbh1rODFER+Hy1CkO7PO1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786887; c=relaxed/simple;
	bh=C8kKQKOtylTtvVHkjEFur6xMaFsKzbM5ZDTUlRRicm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pz5kopT+6k+KEV6RvWu7jgpalJw3HPVy1LCNvJS/2NymGV+Tm9X+enI2CiAvTNaLMZthnA+7/GrlsyYqFwWRYp8/IuymVhBNC/xFeX/6qm9ie8+Dx2BhUj9ZTWmAgRQ9e2mR8GZQJOMOln3oWQjJ105+ZPzbf/kUbjDsLjESqQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QCMoy79y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715786884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uInC5hWDwqGcx7P6rLG2USi6e9+2nLZVOslbhOtiZQ8=;
	b=QCMoy79y2QI6EflgS2YLJN6p6zk/DPe6YTe+o68qHGWkNuPBzqTPsBW/3ikAxLuFkOAEdt
	BEletwakXo9Oc25/PKRdpX5xqt1loGLQUf+BmZufuS4eGX1IrfjReWZV5hPn1UA/9V/J0M
	CBKV5EaCj3FZ6UAcJ5Sqd6Ip1DX7pvg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-OKrgi6wzN1OJxJUn5UMrTA-1; Wed,
 15 May 2024 11:27:42 -0400
X-MC-Unique: OKrgi6wzN1OJxJUn5UMrTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4ABD71C0513F;
	Wed, 15 May 2024 15:27:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.39])
	by smtp.corp.redhat.com (Postfix) with SMTP id 7395F3C27;
	Wed, 15 May 2024 15:27:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 May 2024 17:26:15 +0200 (CEST)
Date: Wed, 15 May 2024 17:26:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Deepak Gupta <debug@rivosinc.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
Message-ID: <20240515152609.GD6821@redhat.com>
References: <ZjyJsl_u_FmYHrki@krava>
 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
 <Zj_enIB_J6pGJ6Nu@krava>
 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
 <ZkKE3qT1X_Jirb92@krava>
 <3e15152888d543d2ee4e5a1d75298c80aa946659.camel@intel.com>
 <ZkQTgQ3aKU4MAjPu@debug.ba.rivosinc.com>
 <20240515111919.GA6821@redhat.com>
 <ZkTIU1QUAJF0f0KK@krava>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkTIU1QUAJF0f0KK@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 05/15, Jiri Olsa wrote:
>
> On Wed, May 15, 2024 at 01:19:20PM +0200, Oleg Nesterov wrote:
> > Let me ask a couple of really stupid questions. What if the shadow stack
> > is "shorter" than the normal stack? I mean,
> >
> > 	enable_shstk()
> > 	{
> > 		prctl(ARCH_SHSTK_SHSTK);

I meant ARCH_SHSTK_ENABLE, of course

> > 	}
> >
> > what happens when enable_shstk() returns?
>
> I think it will crash, there's explanation in the comment in
> tools/testing/selftests/x86/test_shadow_stack.c test

OK, thanks...

But test_shadow_stack.c doesn't do ARCH_PRCTL(ARCH_SHSTK_DISABLE) if
all the tests succeed ? Confused but nevermind.

> > And what is the purpose of fpregs_lock_and_load() ? Why do we need to
> > fpregs_restore_userregs() in shstk_setup() and other places?
> >
> > Oleg.
> >
>


