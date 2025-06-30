Return-Path: <linux-api+bounces-4070-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB066AEEA16
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 00:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D983E1746
	for <lists+linux-api@lfdr.de>; Mon, 30 Jun 2025 22:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08DE2405E4;
	Mon, 30 Jun 2025 22:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHs5iPkD"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20AC17A2F5;
	Mon, 30 Jun 2025 22:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751322063; cv=none; b=RIJ9MmnU8ylVMSH5HuQJwvO0d9a99VP119SjJ8u2GWHf6QCzOJofk6EnwCfcRpIqKAiOf0FLiygw/fCNcN4u/pQYyZ0CSV3Xt3yJjOtqAbumA2Ds8xV0XvlQ+8NtOA3d42hMyuGwufcgPNI9wrXUF+wy/z5x6Y9OhXzWJIxBH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751322063; c=relaxed/simple;
	bh=T+kvLHHNBi3eAVSXnbHKPtUgScri0TI5apBm/HNsjRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYsmJXPqKbVsaY0jRBLZ/5tr1B6oPo0nWxcZF9MhoYzzYtriZsTAADM0TsXsl1S3keHI2oK/3oEXbita6P5I7W/Xe56QSmslRnCUHEMFsY6hhCX4MY2XB3LeXGWiWuFT8NtS+sl8SN8awYtWjVKkSNr8pLro8at7kW919d3UFTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHs5iPkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE43AC4CEE3;
	Mon, 30 Jun 2025 22:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751322063;
	bh=T+kvLHHNBi3eAVSXnbHKPtUgScri0TI5apBm/HNsjRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kHs5iPkDoZZxhxZYpwqKb4DDzqlD1lh64iYCdhDr1E0GLc/snDI2wbqfSfbzzuZ91
	 mnKEFDM4B8MZLwKMHWIVOIVev+4lfQaZSE8MzP3QBELT4QnwwhQpLdk7oHOjsE6ICw
	 MXIqyNHDGVk6qrzAB7qOt99266YST7TB2eh+z6HTcdkhznz2UFTHPoqF10HDwVxgV0
	 pNABKVmn9yYZhmSahUzzusFC7SXqfQS6gxPnS3/ft5GSIbNpgujPF8Cw90ECO5wdfC
	 Zw7CTaTyW2fqigaXsi7hRbKyzt6apMHI8DS8TLJSmE8cipkqJ9od2LZsz21VI910xF
	 RhGUSZrrSExhQ==
Date: Tue, 1 Jul 2025 00:20:58 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
 workflows@vger.kernel.org, tools@kernel.org
Subject: Re: [RFC v2 01/22] kernel/api: introduce kernel API specification
 framework
Message-ID: <20250701002058.1cae5a7e@foz.lan>
In-Reply-To: <874ivxuht8.fsf@trenco.lwn.net>
References: <20250624180742.5795-1-sashal@kernel.org>
	<20250624180742.5795-2-sashal@kernel.org>
	<874ivxuht8.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 30 Jun 2025 13:53:55 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Sasha Levin <sashal@kernel.org> writes:
> 
> > Add a comprehensive framework for formally documenting kernel APIs with
> > inline specifications. This framework provides:
> >
> > - Structured API documentation with parameter specifications, return
> >   values, error conditions, and execution context requirements
> > - Runtime validation capabilities for debugging (CONFIG_KAPI_RUNTIME_CHECKS)
> > - Export of specifications via debugfs for tooling integration
> > - Support for both internal kernel APIs and system calls
> >
> > The framework stores specifications in a dedicated ELF section and
> > provides infrastructure for:
> > - Compile-time validation of specifications
> > - Runtime querying of API documentation
> > - Machine-readable export formats
> > - Integration with existing SYSCALL_DEFINE macros
> >
> > This commit introduces the core infrastructure without modifying any
> > existing APIs. Subsequent patches will add specifications to individual
> > subsystems.
> >
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  Documentation/admin-guide/kernel-api-spec.rst |  507 ++++++
> 
> You need to add that file to index.rst in that directory or it won't be
> pulled into the docs build.
> 
> Wouldn't it be nice to integrate all this stuff with out existing
> kerneldoc mechanism...? :)

+1

Having two different mechanisms (kapi and kerneldoc) makes a lot harder
to maintain kAPI.

Also, IGT (a testing tool for DRM subsystem) used to have a macro
based documentation system. It got outdated with time, as people
ends forgetting to update the macros when changing the code. 
Also, sometimes we want to add some rich text there, with graphs,
tables, ...

More important than that: people end not remembering to add such macros.
As kerneldoc markups are similar to Doxygen and normal C comments,
it is more likely that people will remember.

So, IMO the best would be to use kerneldoc syntax there, letting
Kerneldoc Sphinx extension handling it for docs, while having
tools to implement the other features you mentioned.

Thanks,
Mauro

