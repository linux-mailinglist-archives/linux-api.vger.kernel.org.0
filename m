Return-Path: <linux-api+bounces-2558-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 169EC9AEB30
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2024 17:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BBB5B212A4
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2024 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3C1F5831;
	Thu, 24 Oct 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="D36zNMVY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hh5QbLRf"
X-Original-To: linux-api@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556A11B0F26;
	Thu, 24 Oct 2024 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785489; cv=none; b=H0m5PuQL/7Rq1jqU/LTZ2oIkJzH/Tv0ujuBu7L5mjgsxEdMJAdVURWyLo5pev0xIIt3Cm6WNNtyqsZc3s2yh3HXtYYKTyjm1ozOWkSBtqdd/SHpBSi2HrfcTYAxBDh2my/lETeZSoD+QIRkxYT9i2s0NLC/WXu1brGIqZuiWwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785489; c=relaxed/simple;
	bh=sJ0qFZ56N9+deEyBTI7bnrQCcpatYL7HXOVQoUYL8xU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ehfIneYADFgM/1N3YA2HY9S0v2KOngLAst/vrMzmQoAbZyvV6RqYA2ELQ1won3Edlgc76vInYVragLy+f+TmxtIsg4zYlU5y9T5GPC1hUO0fDKNI8Pt3mJDyDCDXr4Zw5NH8HFNU8j0IMiX3HkdzV3Nvhi1VfkMeOgsL8T/uQyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=D36zNMVY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hh5QbLRf; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 2B9C113802B8;
	Thu, 24 Oct 2024 11:58:05 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 24 Oct 2024 11:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729785485;
	 x=1729871885; bh=iRiibvlu65k3+IssUvOM6jNnfL1+Iddm+Kj9xmOsRQY=; b=
	D36zNMVYFwWpAcmZJroy6fn+v3WdVTH/D/ZaS32wZ95w4yyTbZYVEKlucoh/kBJC
	bXD+HJJT57zypbTpZZM76FA0lEXqDK9343Hr5cblPbeL09j8lqzQ9QIM73v9oIEH
	HlK5S5NEaSdnHxTR/HowMb40I3RDYfGhjZiQzP06VcVZRJCSDlnVFMB7hspjj7DV
	ZYpeAfFMMKTGPy5ClawowlORzQ/WfNUu1I76w7vqSGP8UPgS4FPbtv36pqs935nH
	T5GhAUdHkRRPcG5VGjOmUZNneu8htMJLhxr/UwcQkhkrNk5rUB/WkXxeitGT+zBo
	CYJ+T96hwhIFKkH9mKXgBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729785485; x=
	1729871885; bh=iRiibvlu65k3+IssUvOM6jNnfL1+Iddm+Kj9xmOsRQY=; b=H
	h5QbLRf2SdChDmDhprHP9l+Xw75tDjleno4sj9ghftESGO67S8glbCIwHpk/8sff
	afsXw1XWaNPdwgp3+NVnpsAFlOt8NslDq7QQSz5ZFwcEP1XQ88fIvxYW7sDRUlDG
	SbQDPIk7muv23MDpxATyoPENzEpG1NgeMKtS63nXUBPoUrkbjRodR75ckPZfqiX+
	lCJLMJL0t+e2tG2fpVZv1fVkSCG5Dc1ALkIvFn32VzaDWApvzsALodlUnx0iKNUT
	Zp4Up5fqDSeWWPZ4pRXVeIAucaYdWCrsCOuMAPOuccY+Xxmr8GFEtnOsSsKnmDar
	Bj/DERPAsZaO7cFSiVfgw==
X-ME-Sender: <xms:jG4aZyIRhQ_Zp8_3mDE_04fJJFAZOOJ8u01rtm8pPWYh7aOmW5qCpg>
    <xme:jG4aZ6LzWrggkqYkr6-b_t-afSZImRcxrmzIzra_VU7Wd5p3koGvCR4iFym6pT3-Y
    CR_epaArRbbPLzBDuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsohhnihgtrgguvhgrnhgtvgduse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvggrlhhmvghiugesihhgrghlihgr
    rdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdguvghvsehighgrlhhirgdrtghomhdprh
    gtphhtthhopeguvhhhrghrthesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehp
    vghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehtghhlgieslhhinh
    huthhrohhnihigrdguvgdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegurghvvgesshhtghholhgrsghsrdhnvghtpdhrtghpthhtoheplhhinh
    hugidqrghpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jG4aZyugVULhtERB3eji9CKG3PAA9XeWdK8Kxvyp1YWoyYsbYYj9ww>
    <xmx:jG4aZ3ZA42IBVPNtZItZdY-rnbl7Za0CAk63GUMxZwEtE0_Bd8LVBg>
    <xmx:jG4aZ5Y6uEMYoBgpv8HEf1Ys-VemDJ3M7_5IAl0R4Cb_o-hxDzLRdA>
    <xmx:jG4aZzBSQvEDGscmnj6e8hlKjv4xM-EddG9Wkw21lOzS4pjH6wc5KQ>
    <xmx:jW4aZ7lqwXQkfoa-vZR9lhGF8TFEHySuIPLk2OUEqfyp1cqwKPHJnLoW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 734082220072; Thu, 24 Oct 2024 11:58:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Oct 2024 15:57:44 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Darren Hart" <dvhart@infradead.org>, "Davidlohr Bueso" <dave@stgolabs.net>,
 sonicadvance1@gmail.com
Cc: linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 linux-api@vger.kernel.org
Message-Id: <bde852ec-8e2f-4957-9368-00d8e5a422c4@app.fastmail.com>
In-Reply-To: <20241024145735.162090-2-andrealmeid@igalia.com>
References: <20241024145735.162090-1-andrealmeid@igalia.com>
 <20241024145735.162090-2-andrealmeid@igalia.com>
Subject: Re: [PATCH RFC 1/1] futex: Create set_robust_list2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024, at 14:57, Andr=C3=A9 Almeida wrote:
> This new syscall allows to set multiple list to the same process. There
> are two list types: 32 and 64 bit lists.
>
> It supports up to 10 lists per process (see ROBUST_LISTS_PER_TASK). The
> lists are dynamically allocated on demand, as part of a linked list.
> This is the proposed interface:
>
> 	long set_robust_list2(void *head, int index, unsigned int flags)
>
> Userspace can ask to set the head of a new list using (index =3D -1).
> Kernel will allocate a new list, place in the linked list and return t=
he
> new index to userspace.
>
> Userspace can modify an existing head by using an index >=3D 0. If the
> requested list doesn't exist, an error is returned.
>
> Userspace cannot remove a robust list.
>
> For now, flag is for the list type:
>
> 	enum robust_list_type {
> 	 	ROBUST_LIST_32BIT,
> 		ROBUST_LIST_64BIT,
> 	 };
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Hi Andr=C3=A9,

I have no opinion on the syscall itself, but I'll comment on
the way you hook it up:

>  arch/arm/tools/syscall.tbl             |  1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +

If we agree on the number, this should be added to all
architectures at the same time. In particular, when
you add it to 32-bit arm, it also needs to be in the
corresponding arch/arm64/tools/syscall_32.tbl for
compat mode.

>  include/uapi/asm-generic/unistd.h      |  5 +-

This reminds me that I need to send the patch to remove this
file, nothing should use it any more, though we still have
the copy in tools/include/uapi/asm-generic/unistd.h that
still gets referenced until the scripts are changed to
use the syscall.tbl format.

> +	if (unlikely(!list_empty(list2))) {
> +		list_for_each_entry_safe(curr, n, list2, list) {
> +			if (curr->head !=3D NULL) {
> +				if (curr->list_type =3D=3D ROBUST_LIST_64BIT)
> +					exit_robust_list(tsk, curr->head);
> +				else if (curr->list_type =3D=3D ROBUST_LIST_32BIT)
> +					compat_exit_robust_list(tsk, curr->head);
> +				curr->head =3D NULL;
> +			}

This looks like the behavior of a 32-bit task using
ROBUST_LIST_64BIT is different on native 32-bit kernels
compared to running on compat mode.

Assuming we want them to behave the same way, did you intend
ROBUST_LIST_64BIT to refer to 64-bit pointers on 32-bit
tasks, or should they use normal word-size pointers?

     Arnd

