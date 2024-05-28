Return-Path: <linux-api+bounces-1628-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AAB8D1A2E
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 13:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E6B1F23B36
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 11:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB35916D321;
	Tue, 28 May 2024 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG44VyNI"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C166B13F431;
	Tue, 28 May 2024 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896893; cv=none; b=OHjuY0fMBy5bqKrq6bciioI02IZ5VRgcOJdAthPRaePmoEO4sDJUb7DLlsu+RPYWmPpsUFx1FJhX+BVCOL4Jd8IYnaPDhk5WUUgZDcYRP+0uvOsUmQ5FITEqTCgTg0RaJJYGo0xvhCQ3fFMV927rIbSr3aPSefUGY8GkP76Yzo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896893; c=relaxed/simple;
	bh=XeJxIi6a14rjilHcl8l3kQ5okk7lmMem0yEff2Bo8mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZl+bZspnbfNdM1Jtf9bV6rxERHjv6AjhpkEvoPRLemJN1HJ6RSDKdFcclCVYtICRwrhXoPiP8+pHxnbnoYl9hqHgcCUgzJ6x0gItKhcVLOmZ5swq7v4QcmjJZYM7lkQn4AszaQ8oseWQ6Phma6tGLQcB09VhoMIrMHm62/99fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG44VyNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39872C3277B;
	Tue, 28 May 2024 11:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716896893;
	bh=XeJxIi6a14rjilHcl8l3kQ5okk7lmMem0yEff2Bo8mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nG44VyNIHnIx++HWkJExvRPBLAlMzM4Z7uZRrF2a3yBn7+MXwMm8U2u85VSB2J1SJ
	 w2vVen2+NivkzUQ67RYEwdnw28Cizh8IFwlfMs62YHsM0HNF8UnPF3lrL3kW9lsm99
	 82IcvBePDFuHb6f67FPbVQ9LFaoeTHk9rzo1FXUiRq6XXGYVJgBoPoMCG4tJ3HDYfi
	 GzmZWfrcwKA9V72kRGvtD09rPjO0AT8mkadlrXpBH4+FVnfEbeHoqUqjs5wlSM2IEf
	 SgKbBCsQZUvJTvoo6PibWJOVVtZ5d42Oe4/3tUwCPWIKxNAK52beln3ZQa3XVVCnje
	 d2dxdSLsotFoA==
Date: Tue, 28 May 2024 13:48:10 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-man@vger.kernel.org, libc-alpha@sourceware.org, 
	Alejandro Colomar <alx@kernel.org>
Subject: [PATCH v1 2/2] uapi/linux/prctl: Use the UL integer suffix for bit
 fields of width long
Message-ID: <20240528114750.106187-3-alx@kernel.org>
X-Mailer: git-send-email 2.45.1
References: <x6r3yc6l34g4k5g3tm6ywecdqux54xlpid7bp2fa7hvm43luc7@6fjgaxgm5uyj>
 <20240528114750.106187-1-alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ztum7alhw4w6fkdf"
Content-Disposition: inline
In-Reply-To: <20240528114750.106187-1-alx@kernel.org>


--ztum7alhw4w6fkdf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-man@vger.kernel.org, libc-alpha@sourceware.org, 
	Alejandro Colomar <alx@kernel.org>
Subject: [PATCH v1 2/2] uapi/linux/prctl: Use the UL integer suffix for bit
 fields of width long
References: <x6r3yc6l34g4k5g3tm6ywecdqux54xlpid7bp2fa7hvm43luc7@6fjgaxgm5uyj>
 <20240528114750.106187-1-alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240528114750.106187-1-alx@kernel.org>

The prctl(2) wrapper provided by glibc uses a variadic argument list.
This means that the arguments *must* have the right type (and more
importantly, the right width).  To avoid the user having to cast these
constants, provide them with the appropriate width, that of a long.

These are bit fields, and bitwise operations are dangerous on signed
integers, so let's make sure they are unsigned.

Link: <https://inbox.sourceware.org/libc-alpha/x6r3yc6l34g4k5g3tm6ywecdqux5=
4xlpid7bp2fa7hvm43luc7@6fjgaxgm5uyj/T/>
Cc: <linux-api@vger.kernel.org>
Cc: <linux-man@vger.kernel.org>
Cc: <libc-alpha@sourceware.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/uapi/linux/prctl.h | 60 +++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 60e14adb8d20..c016c316f3c5 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -33,12 +33,12 @@
 /* Get/set floating-point exception mode (if meaningful) */
 #define PR_GET_FPEXC	11
 #define PR_SET_FPEXC	12
-# define PR_FP_EXC_SW_ENABLE	0x80	/* Use FPEXC for FP exception enables */
-# define PR_FP_EXC_DIV		0x010000	/* floating point divide by zero */
-# define PR_FP_EXC_OVF		0x020000	/* floating point overflow */
-# define PR_FP_EXC_UND		0x040000	/* floating point underflow */
-# define PR_FP_EXC_RES		0x080000	/* floating point inexact result */
-# define PR_FP_EXC_INV		0x100000	/* floating point invalid operation */
+# define PR_FP_EXC_SW_ENABLE	0x80UL	/* Use FPEXC for FP exception enables =
*/
+# define PR_FP_EXC_DIV		0x010000UL	/* floating point divide by zero */
+# define PR_FP_EXC_OVF		0x020000UL	/* floating point overflow */
+# define PR_FP_EXC_UND		0x040000UL	/* floating point underflow */
+# define PR_FP_EXC_RES		0x080000UL	/* floating point inexact result */
+# define PR_FP_EXC_INV		0x100000UL	/* floating point invalid operation */
 # define PR_FP_EXC_DISABLED	0L	/* FP exceptions disabled */
 # define PR_FP_EXC_NONRECOV	1L	/* async non-recoverable exc. mode */
 # define PR_FP_EXC_ASYNC	2L	/* async recoverable exception mode */
@@ -188,8 +188,8 @@ struct prctl_mm_map {
=20
 #define PR_SET_FP_MODE		45
 #define PR_GET_FP_MODE		46
-# define PR_FP_MODE_FR		(1 << 0)	/* 64b FP registers */
-# define PR_FP_MODE_FRE		(1 << 1)	/* 32b compatibility */
+# define PR_FP_MODE_FR		(1UL << 0)	/* 64b FP registers */
+# define PR_FP_MODE_FRE		(1UL << 1)	/* 32b compatibility */
=20
 /* Control the ambient capability set */
 #define PR_CAP_AMBIENT			47
@@ -201,11 +201,11 @@ struct prctl_mm_map {
 /* arm64 Scalable Vector Extension controls */
 /* Flag values must be kept in sync with ptrace NT_ARM_SVE interface */
 #define PR_SVE_SET_VL			50	/* set task vector length */
-# define PR_SVE_SET_VL_ONEXEC		(1 << 18) /* defer effect until exec */
+# define PR_SVE_SET_VL_ONEXEC		(1UL << 18) /* defer effect until exec */
 #define PR_SVE_GET_VL			51	/* get task vector length */
 /* Bits common to PR_SVE_SET_VL and PR_SVE_GET_VL */
-# define PR_SVE_VL_LEN_MASK		0xffff
-# define PR_SVE_VL_INHERIT		(1 << 17) /* inherit across exec */
+# define PR_SVE_VL_LEN_MASK		0xffffUL
+# define PR_SVE_VL_INHERIT		(1UL << 17) /* inherit across exec */
=20
 /* Per task speculation control */
 #define PR_GET_SPECULATION_CTRL		52
@@ -215,7 +215,7 @@ struct prctl_mm_map {
 # define PR_SPEC_INDIRECT_BRANCH	1L
 # define PR_SPEC_L1D_FLUSH		2L
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
-# define PR_SPEC_NOT_AFFECTED		0
+# define PR_SPEC_NOT_AFFECTED		0UL
 # define PR_SPEC_PRCTL			(1UL << 0)
 # define PR_SPEC_ENABLE			(1UL << 1)
 # define PR_SPEC_DISABLE		(1UL << 2)
@@ -240,10 +240,10 @@ struct prctl_mm_map {
 # define PR_MTE_TCF_ASYNC		(1UL << 2)
 # define PR_MTE_TCF_MASK		(PR_MTE_TCF_SYNC | PR_MTE_TCF_ASYNC)
 /* MTE tag inclusion mask */
-# define PR_MTE_TAG_SHIFT		3
+# define PR_MTE_TAG_SHIFT		3UL
 # define PR_MTE_TAG_MASK		(0xffffUL << PR_MTE_TAG_SHIFT)
 /* Unused; kept only for source compatibility */
-# define PR_MTE_TCF_SHIFT		1
+# define PR_MTE_TCF_SHIFT		1UL
=20
 /* Control reclaim behavior when allocating memory */
 #define PR_SET_IO_FLUSHER		57
@@ -275,11 +275,11 @@ struct prctl_mm_map {
 /* arm64 Scalable Matrix Extension controls */
 /* Flag values must be in sync with SVE versions */
 #define PR_SME_SET_VL			63	/* set task vector length */
-# define PR_SME_SET_VL_ONEXEC		(1 << 18) /* defer effect until exec */
+# define PR_SME_SET_VL_ONEXEC		(1UL << 18) /* defer effect until exec */
 #define PR_SME_GET_VL			64	/* get task vector length */
 /* Bits common to PR_SME_SET_VL and PR_SME_GET_VL */
-# define PR_SME_VL_LEN_MASK		0xffff
-# define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
+# define PR_SME_VL_LEN_MASK		0xffffUL
+# define PR_SME_VL_INHERIT		(1UL << 17) /* inherit across exec */
=20
 /* Memory deny write / execute */
 #define PR_SET_MDWE			65
@@ -298,13 +298,13 @@ struct prctl_mm_map {
=20
 #define PR_RISCV_V_SET_CONTROL		69
 #define PR_RISCV_V_GET_CONTROL		70
-# define PR_RISCV_V_VSTATE_CTRL_DEFAULT		0
-# define PR_RISCV_V_VSTATE_CTRL_OFF		1
-# define PR_RISCV_V_VSTATE_CTRL_ON		2
-# define PR_RISCV_V_VSTATE_CTRL_INHERIT		(1 << 4)
-# define PR_RISCV_V_VSTATE_CTRL_CUR_MASK	0x3
-# define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
-# define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
+# define PR_RISCV_V_VSTATE_CTRL_DEFAULT		0UL
+# define PR_RISCV_V_VSTATE_CTRL_OFF		1UL
+# define PR_RISCV_V_VSTATE_CTRL_ON		2UL
+# define PR_RISCV_V_VSTATE_CTRL_INHERIT		(1UL << 4)
+# define PR_RISCV_V_VSTATE_CTRL_CUR_MASK	0x3UL
+# define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xcUL
+# define PR_RISCV_V_VSTATE_CTRL_MASK		0x1fUL
=20
 #define PR_RISCV_SET_ICACHE_FLUSH_CTX	71
 # define PR_RISCV_CTX_SW_FENCEI_ON	0L
@@ -321,11 +321,11 @@ struct prctl_mm_map {
 # define PR_PPC_DEXCR_SRAPD		2L /* Subroutine return address prediction di=
sable */
 # define PR_PPC_DEXCR_NPHIE		3L /* Non-privileged hash instruction enable =
*/
 /* Action to apply / return */
-# define PR_PPC_DEXCR_CTRL_EDITABLE	 0x1 /* Aspect can be modified with PR=
_PPC_SET_DEXCR */
-# define PR_PPC_DEXCR_CTRL_SET		 0x2 /* Set the aspect for this process */
-# define PR_PPC_DEXCR_CTRL_CLEAR	 0x4 /* Clear the aspect for this process=
 */
-# define PR_PPC_DEXCR_CTRL_SET_ONEXEC	 0x8 /* Set the aspect on exec */
-# define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10 /* Clear the aspect on exec */
-# define PR_PPC_DEXCR_CTRL_MASK		0x1f
+# define PR_PPC_DEXCR_CTRL_EDITABLE	 0x1UL /* Aspect can be modified with =
PR_PPC_SET_DEXCR */
+# define PR_PPC_DEXCR_CTRL_SET		 0x2UL /* Set the aspect for this process =
*/
+# define PR_PPC_DEXCR_CTRL_CLEAR	 0x4UL /* Clear the aspect for this proce=
ss */
+# define PR_PPC_DEXCR_CTRL_SET_ONEXEC	 0x8UL /* Set the aspect on exec */
+# define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10UL /* Clear the aspect on exec=
 */
+# define PR_PPC_DEXCR_CTRL_MASK		0x1fUL
=20
 #endif /* _LINUX_PRCTL_H */
--=20
2.45.1


--ztum7alhw4w6fkdf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZVxHoACgkQnowa+77/
2zKJ9Q/9H4YJbOYcnotEiH8LVnL8f0SJ3Rnswj6U0cwu0XNzPaZXEyOV7B+wdc27
AWaXCePojA8TVw+ayFZSHn98d33Edh/UeMBpsfzxHCBFvlIbRWnbIKbRXUc77Emc
XCR1WWUj9egv9h1REuz+ZCLqnfQSnDB64K4gy/UuafDO2Ylc9V6pa9Cb9AbLpky6
UGCPowB31SE4YcS+geENq4FhSajTEcbD4t5ubrdVNI5ME1V473rQQuJBg2Ulmp4f
w0b+2ViQLv6SexoowgmEZORMW4W5zH1JI4lwyHYsjB8YNCojBA+5/hO7OxvVncvz
ffScpCoz7+GpvvHMQT2vqXtCTF2+tdTOreBflrWiJHErGxkZJnbj/1kmuSVa2y/n
b3B/E6AAwz0B4TLBVv70gxVI0E6DYDK5J/087A+YYjN4U50lnbyghsku1tBVQFnV
Z767t1/pTz6kNbO1hJA8d7FgMlcQ8hDcnA77DtZuSCxz+F6ym9D4RnfYSf2tzCRW
NqJES/LPPJEoO9o8DjtOpelojE337TZy/7iZMLoWFg+sasnz49UmVNi9X6Dr1XwR
/OV2jL93eescXpS2uxFxjUQB1dt1OzSdlm3F+Ef2b45BbF3M8BbAzoWfCjbhlrZ8
FWYFGYTMJMuvXvf7H47d5QZMXpd4T8DtSW7vCew+R51XOobhDJM=
=Ww8X
-----END PGP SIGNATURE-----

--ztum7alhw4w6fkdf--

