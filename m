Return-Path: <linux-api+bounces-4095-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70415AEFE4B
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 17:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2681884798
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 15:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E99927933A;
	Tue,  1 Jul 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aK8Qo6eA"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1DA2777FC;
	Tue,  1 Jul 2025 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383534; cv=none; b=FGG5QXkjoR0W2tn3LmNcLnz9j3CgqXAnO6oNIIL8vgAMKfAtv3qus545OUGgoBpIW7ybPOZFj5uP6bTrHE6qP/rkdej+EHPCpaF08+c/lAjaAMWptHHSqIO7L+PUFpxxq1EHIhA4lixBi61V03OE7LxdcQ1SlK8PUKDDJ2bjgGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383534; c=relaxed/simple;
	bh=DIA69QI1E2BrYc+r2/ZtTjhWU3b//5pH+ynl6jTsDVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N98JsZiEnW+s3m80cm8tnzcChU2EZAa7iabkZRGgwbJ0T82AfY7eEa+xlJm1MEqMB40spaZ/Cz3czQajjrssWkQ01SqAiOmETGx0rOl6VjipT2BJY5vK1Y2QenjoD1zyFEYDK5HxZsSRRfDOQ4FEeKl9Bbt7oVwA3MB0oJg+1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aK8Qo6eA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23963C4CEEB;
	Tue,  1 Jul 2025 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751383533;
	bh=DIA69QI1E2BrYc+r2/ZtTjhWU3b//5pH+ynl6jTsDVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aK8Qo6eAJR/z7niGBhdup+2w8j7tc9w4vStYDQKRZbfm5lY2tw8IEJ5Vbzn5Pxa/Z
	 IP9Bgy8jA0RvDhH0nxjirtELANGofmKOJiMUZJXZ208uh1DH+u9PXhVEUbQ+ulku/W
	 7MAUlUpxSoUyWmClDX94IoGQ3pKISWMFA5qjk1DD+6qoOvX4n3ZYOSQYoiSHQ11J0H
	 l1N8iSAmIDwB+0inds9d9kfL4OQhoUDq0InomACOTZG9e/pS+aYJ+lPdCRaf5KXIZy
	 1mp/wZoN4j6NTwB30RCGMSMIVJzg8quVwgKpG2SWweijScQTQpSB0qUajmighDMjEh
	 lk/OPqPC9G6Lg==
Date: Tue, 1 Jul 2025 17:25:27 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
 workflows@vger.kernel.org, tools@kernel.org
Subject: Re: [RFC v2 01/22] kernel/api: introduce kernel API specification
 framework
Message-ID: <20250701172527.5adde449@sal.lan>
In-Reply-To: <aGPvR-Mj6aR4Y8B5@lappy>
References: <20250624180742.5795-1-sashal@kernel.org>
	<20250624180742.5795-2-sashal@kernel.org>
	<874ivxuht8.fsf@trenco.lwn.net>
	<20250701002058.1cae5a7e@foz.lan>
	<aGPvR-Mj6aR4Y8B5@lappy>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Tue, 1 Jul 2025 10:23:03 -0400
Sasha Levin <sashal@kernel.org> escreveu:

> On Tue, Jul 01, 2025 at 12:20:58AM +0200, Mauro Carvalho Chehab wrote:
> >Em Mon, 30 Jun 2025 13:53:55 -0600
> >Jonathan Corbet <corbet@lwn.net> escreveu:
> > =20
> >> Sasha Levin <sashal@kernel.org> writes:
> >> =20
> >> > Add a comprehensive framework for formally documenting kernel APIs w=
ith
> >> > inline specifications. This framework provides:
> >> >
> >> > - Structured API documentation with parameter specifications, return
> >> >   values, error conditions, and execution context requirements
> >> > - Runtime validation capabilities for debugging (CONFIG_KAPI_RUNTIME=
_CHECKS)
> >> > - Export of specifications via debugfs for tooling integration
> >> > - Support for both internal kernel APIs and system calls
> >> >
> >> > The framework stores specifications in a dedicated ELF section and
> >> > provides infrastructure for:
> >> > - Compile-time validation of specifications
> >> > - Runtime querying of API documentation
> >> > - Machine-readable export formats
> >> > - Integration with existing SYSCALL_DEFINE macros
> >> >
> >> > This commit introduces the core infrastructure without modifying any
> >> > existing APIs. Subsequent patches will add specifications to individ=
ual
> >> > subsystems.
> >> >
> >> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> >> > ---
> >> >  Documentation/admin-guide/kernel-api-spec.rst |  507 ++++++ =20
> >>
> >> You need to add that file to index.rst in that directory or it won't be
> >> pulled into the docs build.
> >>
> >> Wouldn't it be nice to integrate all this stuff with out existing
> >> kerneldoc mechanism...? :) =20
> >
> >+1
> >
> >Having two different mechanisms (kapi and kerneldoc) makes a lot harder
> >to maintain kAPI. =20
>=20
> I hated the idea of not reusing kerneldoc.
>=20
> My concern with kerneldoc was that I can't manipulate the
> information it stores in the context of a kernel build. So for example,
> I wasn't sure how I can expose information stored within kerneldoc via
> debugfs on a running system (or how I can store it within the vmlinux
> for later extraction from the binary built kernel).
>=20
> I did some research based on your proposal, and I think I was incorrect
> with the assumption above. I suppose we could do something like the
> following:
>=20
> 1. Add new section patterns to doc_sect regex in to include API
> specification sections: api-type, api-version, param-type, param-flags,
> param-constraint, error-code, capability, signal, lock-req, since...
>  =20
> 2. Create new output module (scripts/lib/kdoc/kdoc_apispec.py?) to
> generate C macro invocations from parsed data.
>=20
> Which will generate output like:
>=20
>     DEFINE_KERNEL_API_SPEC(function_name)
>         KAPI_DESCRIPTION("...")=20
>         KAPI_PARAM(0, "name", "type", "desc")
>             KAPI_PARAM_TYPE(KAPI_TYPE_INT)
>             KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
>         KAPI_PARAM_END
>     KAPI_END_SPEC=20

> 3. And then via makefile we can:=20
>     - Generate API specs from kerneldoc comments
>     - Include generated specs conditionally based on CONFIG_KERNEL_API_SP=
EC
>=20
> Allowing us to just have these in the relevant source files:
>     #ifdef CONFIG_KERNEL_API_SPEC
>     #include "socket.apispec.h"
>     #endif
>=20
>=20
> In theory, all of that will let us have something like the following in
> kerneldoc:
>=20
> - @api-type: syscall
> - @api-version: 1
> - @context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
> - @param-type: family, KAPI_TYPE_INT
> - @param-flags: family, KAPI_PARAM_IN
> - @param-range: family, 0, 45
> - @param-mask: type, SOCK_TYPE_MASK | SOCK_CLOEXEC | SOCK_NONBLOCK
> - @error-code: -EAFNOSUPPORT, "Address family not supported"
> - @error-condition: -EAFNOSUPPORT, "family < 0 || family >=3D NPROTO"
> - @capability: CAP_NET_RAW, KAPI_CAP_GRANT_PERMISSION
> - @capability-allows: CAP_NET_RAW, "Create SOCK_RAW sockets"
> - @since: 2.0
> - @return-type: KAPI_TYPE_FD
> - @return-check: KAPI_RETURN_ERROR_CHECK
>=20
> How does it sound? I'm pretty excited about the possiblity to align this
> with kerneldoc. Please poke holes in the plan :)

Sounds like a plan!

We did something somewhat similar on IGT.=20

The python classes there were written with the goal to document
tests, so its examples are related to test docs, but I wrote it
to be generic.

There, all fields comes form a JSON file like this:

	https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/intel=
/xe_test_config.json?ref_type=3Dheads

which describes what fields will be used. It also lists file
patterns that will use it. The fields allow hierarchical
grouping, with could be interesting for some types of fields.

=46rom the json example (I dropped the optional field description
from the example, to make it cleaner):

	"Category": {
	    "Mega feature": {
            	"Sub-category": {},
	    }
	...
 	"Test category": {},
	"Issue": {},
	...

The hierarchical part is useful to properly order kapi content
without the need to add multiple Sphinx markups to manually reorder
the output inside the .rst files.

(*) I would avoid hardcoding the fields/structures, as eventually
    we may need more flexibility to add fields and/or having some
    fields that are specific, for instance, to debugfs or sysfs.

The python class it uses is at:
	https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/scripts/tes=
t_list.py?ref_type=3Dheads

and caller is at:
	https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/scripts/igt=
_doc.py?ref_type=3Dheads

Eventually you may find something useful there. If so, feel free to
pick from it.

Regards,
Mauro

