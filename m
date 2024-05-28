Return-Path: <linux-api+bounces-1627-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE0E8D1A2A
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 13:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401DC28A383
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 11:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE8916D315;
	Tue, 28 May 2024 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6jbRQIq"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F8913F431;
	Tue, 28 May 2024 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896889; cv=none; b=sSOlRGvKkuCMcL3XkcvLrp6xvidTwCG6PlfDEewpRdnEsxOcZpWIetCWM8ZqDQkY5lJ91l2HbJMx2zMRLQXZhJSBso+73jO9uWdEgc5MeBQQJLc9aPfTp1Ns8ZmGn6p6WbXteGauYq79N7GFkP49IXQmkFKWxxBIiBL+oYIqme8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896889; c=relaxed/simple;
	bh=/3R7Lok4WL8HaPiOOfTeRyYmBXF3VIcE0RLZlmUPJ1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJbHFMrITpNSxoRripCQYKssc/SWGkN0dg3YbfRjm42hsJCfE+7IHXaeh1hAxYpjMwQW/7R8q5PCXCiIt6DqdVnU1SFxCCjLyf93ImzW8FDmDLwRt7tgf/dXxp+OCZUMNDSMvVISFhjXHT2250GrU54HwoK4sIEh2acylmdQCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6jbRQIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363FAC3277B;
	Tue, 28 May 2024 11:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716896889;
	bh=/3R7Lok4WL8HaPiOOfTeRyYmBXF3VIcE0RLZlmUPJ1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6jbRQIqnhjqJqYASXVF7vvcT6m6l5AIAQwBV2USNLfUhycYefcVrHtRZEC5J5l3q
	 mCFDb1Wa6k2kz2d3rv8B+tdK+J7UfEaM9KEpvZ8ofTaaX34EcgoFh1d52tU7m+qvfb
	 RwpmKk08M3YsJsBtDXFDPiQWskjs1G81Nr/f0M9NYbXrfFiShiBlPQMGE7zvCuO2UK
	 u51tsVlGnlC/0H/AWE6Qs7amE0lb9OCZdgR0YOYc8UBb6oJ4q1stQI8UAJLEato9IU
	 Wmc88DWpZuWJ8BPiV0SY5ILulwd5yiFbvTbRhoznGFWMLdnKoUkTCuM6FsbYsPkPQU
	 V7TvKFLu6XoBg==
Date: Tue, 28 May 2024 13:48:06 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-man@vger.kernel.org, libc-alpha@sourceware.org, 
	Alejandro Colomar <alx@kernel.org>
Subject: [PATCH v1 1/2] uapi/linux/prctl: Use the L integer suffix for
 enumerations of width long
Message-ID: <20240528114750.106187-2-alx@kernel.org>
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
	protocol="application/pgp-signature"; boundary="chovke2wgn4y6l4e"
Content-Disposition: inline
In-Reply-To: <20240528114750.106187-1-alx@kernel.org>


--chovke2wgn4y6l4e
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-man@vger.kernel.org, libc-alpha@sourceware.org, 
	Alejandro Colomar <alx@kernel.org>
Subject: [PATCH v1 1/2] uapi/linux/prctl: Use the L integer suffix for
 enumerations of width long
References: <x6r3yc6l34g4k5g3tm6ywecdqux54xlpid7bp2fa7hvm43luc7@6fjgaxgm5uyj>
 <20240528114750.106187-1-alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240528114750.106187-1-alx@kernel.org>

The prctl(2) wrapper provided by glibc uses a variadic argument list.
This means that the arguments *must* have the right type (and more
importantly, the right width).  To avoid the user having to cast these
constants, provide them with the appropriate width, that of a long.

Having the width of a long is sufficient, and we don't need UL.  Let's
reserve that suffix for bit fields, which need to be unsigned to avoid
easily triggering undefined (or implementation-defined) behavior.

Link: <https://inbox.sourceware.org/libc-alpha/x6r3yc6l34g4k5g3tm6ywecdqux5=
4xlpid7bp2fa7hvm43luc7@6fjgaxgm5uyj/T/>
Cc: <linux-api@vger.kernel.org>
Cc: <linux-man@vger.kernel.org>
Cc: <libc-alpha@sourceware.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/uapi/linux/prctl.h | 126 ++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 35791791a879..60e14adb8d20 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -16,8 +16,8 @@
 /* Get/set unaligned access control bits (if meaningful) */
 #define PR_GET_UNALIGN	  5
 #define PR_SET_UNALIGN	  6
-# define PR_UNALIGN_NOPRINT	1	/* silently fix up unaligned user accesses */
-# define PR_UNALIGN_SIGBUS	2	/* generate SIGBUS on unaligned user access */
+# define PR_UNALIGN_NOPRINT	1L	/* silently fix up unaligned user accesses =
*/
+# define PR_UNALIGN_SIGBUS	2L	/* generate SIGBUS on unaligned user access =
*/
=20
 /* Get/set whether or not to drop capabilities on setuid() away from
  * uid 0 (as per security/commoncap.c) */
@@ -27,8 +27,8 @@
 /* Get/set floating-point emulation control bits (if meaningful) */
 #define PR_GET_FPEMU  9
 #define PR_SET_FPEMU 10
-# define PR_FPEMU_NOPRINT	1	/* silently emulate fp operations accesses */
-# define PR_FPEMU_SIGFPE	2	/* don't emulate fp operations, send SIGFPE ins=
tead */
+# define PR_FPEMU_NOPRINT	1L	/* silently emulate fp operations accesses */
+# define PR_FPEMU_SIGFPE	2L	/* don't emulate fp operations, send SIGFPE in=
stead */
=20
 /* Get/set floating-point exception mode (if meaningful) */
 #define PR_GET_FPEXC	11
@@ -39,18 +39,18 @@
 # define PR_FP_EXC_UND		0x040000	/* floating point underflow */
 # define PR_FP_EXC_RES		0x080000	/* floating point inexact result */
 # define PR_FP_EXC_INV		0x100000	/* floating point invalid operation */
-# define PR_FP_EXC_DISABLED	0	/* FP exceptions disabled */
-# define PR_FP_EXC_NONRECOV	1	/* async non-recoverable exc. mode */
-# define PR_FP_EXC_ASYNC	2	/* async recoverable exception mode */
-# define PR_FP_EXC_PRECISE	3	/* precise exception mode */
+# define PR_FP_EXC_DISABLED	0L	/* FP exceptions disabled */
+# define PR_FP_EXC_NONRECOV	1L	/* async non-recoverable exc. mode */
+# define PR_FP_EXC_ASYNC	2L	/* async recoverable exception mode */
+# define PR_FP_EXC_PRECISE	3L	/* precise exception mode */
=20
 /* Get/set whether we use statistical process timing or accurate timestamp
  * based process timing */
 #define PR_GET_TIMING   13
 #define PR_SET_TIMING   14
-# define PR_TIMING_STATISTICAL  0       /* Normal, traditional,
+# define PR_TIMING_STATISTICAL  0L      /* Normal, traditional,
                                                    statistical process tim=
ing */
-# define PR_TIMING_TIMESTAMP    1       /* Accurate timestamp based
+# define PR_TIMING_TIMESTAMP    1L      /* Accurate timestamp based
                                                    process timing */
=20
 #define PR_SET_NAME    15		/* Set process name */
@@ -59,9 +59,9 @@
 /* Get/set process endian */
 #define PR_GET_ENDIAN	19
 #define PR_SET_ENDIAN	20
-# define PR_ENDIAN_BIG		0
-# define PR_ENDIAN_LITTLE	1	/* True little endian mode */
-# define PR_ENDIAN_PPC_LITTLE	2	/* "PowerPC" pseudo little endian */
+# define PR_ENDIAN_BIG		0L
+# define PR_ENDIAN_LITTLE	1L	/* True little endian mode */
+# define PR_ENDIAN_PPC_LITTLE	2L	/* "PowerPC" pseudo little endian */
=20
 /* Get/set process seccomp mode */
 #define PR_GET_SECCOMP	21
@@ -74,8 +74,8 @@
 /* Get/set the process' ability to use the timestamp counter instruction */
 #define PR_GET_TSC 25
 #define PR_SET_TSC 26
-# define PR_TSC_ENABLE		1	/* allow the use of the timestamp counter */
-# define PR_TSC_SIGSEGV		2	/* throw a SIGSEGV instead of reading the TSC */
+# define PR_TSC_ENABLE		1L	/* allow the use of the timestamp counter */
+# define PR_TSC_SIGSEGV		2L	/* throw a SIGSEGV instead of reading the TSC =
*/
=20
 /* Get/set securebits (as per security/commoncap.c) */
 #define PR_GET_SECUREBITS 27
@@ -96,12 +96,12 @@
  * This influences when the process gets killed on a memory corruption.
  */
 #define PR_MCE_KILL	33
-# define PR_MCE_KILL_CLEAR   0
-# define PR_MCE_KILL_SET     1
+# define PR_MCE_KILL_CLEAR   0L
+# define PR_MCE_KILL_SET     1L
=20
-# define PR_MCE_KILL_LATE    0
-# define PR_MCE_KILL_EARLY   1
-# define PR_MCE_KILL_DEFAULT 2
+# define PR_MCE_KILL_LATE    0L
+# define PR_MCE_KILL_EARLY   1L
+# define PR_MCE_KILL_DEFAULT 2L
=20
 #define PR_MCE_KILL_GET 34
=20
@@ -109,21 +109,21 @@
  * Tune up process memory map specifics.
  */
 #define PR_SET_MM		35
-# define PR_SET_MM_START_CODE		1
-# define PR_SET_MM_END_CODE		2
-# define PR_SET_MM_START_DATA		3
-# define PR_SET_MM_END_DATA		4
-# define PR_SET_MM_START_STACK		5
-# define PR_SET_MM_START_BRK		6
-# define PR_SET_MM_BRK			7
-# define PR_SET_MM_ARG_START		8
-# define PR_SET_MM_ARG_END		9
-# define PR_SET_MM_ENV_START		10
-# define PR_SET_MM_ENV_END		11
-# define PR_SET_MM_AUXV			12
-# define PR_SET_MM_EXE_FILE		13
-# define PR_SET_MM_MAP			14
-# define PR_SET_MM_MAP_SIZE		15
+# define PR_SET_MM_START_CODE		1L
+# define PR_SET_MM_END_CODE		2L
+# define PR_SET_MM_START_DATA		3L
+# define PR_SET_MM_END_DATA		4L
+# define PR_SET_MM_START_STACK		5L
+# define PR_SET_MM_START_BRK		6L
+# define PR_SET_MM_BRK			7L
+# define PR_SET_MM_ARG_START		8L
+# define PR_SET_MM_ARG_END		9L
+# define PR_SET_MM_ENV_START		10L
+# define PR_SET_MM_ENV_END		11L
+# define PR_SET_MM_AUXV			12L
+# define PR_SET_MM_EXE_FILE		13L
+# define PR_SET_MM_MAP			14L
+# define PR_SET_MM_MAP_SIZE		15L
=20
 /*
  * This structure provides new memory descriptor
@@ -193,10 +193,10 @@ struct prctl_mm_map {
=20
 /* Control the ambient capability set */
 #define PR_CAP_AMBIENT			47
-# define PR_CAP_AMBIENT_IS_SET		1
-# define PR_CAP_AMBIENT_RAISE		2
-# define PR_CAP_AMBIENT_LOWER		3
-# define PR_CAP_AMBIENT_CLEAR_ALL	4
+# define PR_CAP_AMBIENT_IS_SET		1L
+# define PR_CAP_AMBIENT_RAISE		2L
+# define PR_CAP_AMBIENT_LOWER		3L
+# define PR_CAP_AMBIENT_CLEAR_ALL	4L
=20
 /* arm64 Scalable Vector Extension controls */
 /* Flag values must be kept in sync with ptrace NT_ARM_SVE interface */
@@ -211,9 +211,9 @@ struct prctl_mm_map {
 #define PR_GET_SPECULATION_CTRL		52
 #define PR_SET_SPECULATION_CTRL		53
 /* Speculation control variants */
-# define PR_SPEC_STORE_BYPASS		0
-# define PR_SPEC_INDIRECT_BRANCH	1
-# define PR_SPEC_L1D_FLUSH		2
+# define PR_SPEC_STORE_BYPASS		0L
+# define PR_SPEC_INDIRECT_BRANCH	1L
+# define PR_SPEC_L1D_FLUSH		2L
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
@@ -251,11 +251,11 @@ struct prctl_mm_map {
=20
 /* Dispatch syscalls to a userspace handler */
 #define PR_SET_SYSCALL_USER_DISPATCH	59
-# define PR_SYS_DISPATCH_OFF		0
-# define PR_SYS_DISPATCH_ON		1
+# define PR_SYS_DISPATCH_OFF		0L
+# define PR_SYS_DISPATCH_ON		1L
 /* The control values for the user space selector when dispatch is enabled=
 */
-# define SYSCALL_DISPATCH_FILTER_ALLOW	0
-# define SYSCALL_DISPATCH_FILTER_BLOCK	1
+# define SYSCALL_DISPATCH_FILTER_ALLOW	0L
+# define SYSCALL_DISPATCH_FILTER_BLOCK	1L
=20
 /* Set/get enabled arm64 pointer authentication keys */
 #define PR_PAC_SET_ENABLED_KEYS		60
@@ -263,14 +263,14 @@ struct prctl_mm_map {
=20
 /* Request the scheduler to share a core */
 #define PR_SCHED_CORE			62
-# define PR_SCHED_CORE_GET		0
-# define PR_SCHED_CORE_CREATE		1 /* create unique core_sched cookie */
-# define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
-# define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
-# define PR_SCHED_CORE_MAX		4
-# define PR_SCHED_CORE_SCOPE_THREAD		0
-# define PR_SCHED_CORE_SCOPE_THREAD_GROUP	1
-# define PR_SCHED_CORE_SCOPE_PROCESS_GROUP	2
+# define PR_SCHED_CORE_GET		0L
+# define PR_SCHED_CORE_CREATE		1L /* create unique core_sched cookie */
+# define PR_SCHED_CORE_SHARE_TO		2L /* push core_sched cookie to pid */
+# define PR_SCHED_CORE_SHARE_FROM	3L /* pull core_sched cookie to pid */
+# define PR_SCHED_CORE_MAX		4L
+# define PR_SCHED_CORE_SCOPE_THREAD		0L
+# define PR_SCHED_CORE_SCOPE_THREAD_GROUP	1L
+# define PR_SCHED_CORE_SCOPE_PROCESS_GROUP	2L
=20
 /* arm64 Scalable Matrix Extension controls */
 /* Flag values must be in sync with SVE versions */
@@ -289,7 +289,7 @@ struct prctl_mm_map {
 #define PR_GET_MDWE			66
=20
 #define PR_SET_VMA		0x53564d41
-# define PR_SET_VMA_ANON_NAME		0
+# define PR_SET_VMA_ANON_NAME		0L
=20
 #define PR_GET_AUXV			0x41555856
=20
@@ -307,19 +307,19 @@ struct prctl_mm_map {
 # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
=20
 #define PR_RISCV_SET_ICACHE_FLUSH_CTX	71
-# define PR_RISCV_CTX_SW_FENCEI_ON	0
-# define PR_RISCV_CTX_SW_FENCEI_OFF	1
-# define PR_RISCV_SCOPE_PER_PROCESS	0
-# define PR_RISCV_SCOPE_PER_THREAD	1
+# define PR_RISCV_CTX_SW_FENCEI_ON	0L
+# define PR_RISCV_CTX_SW_FENCEI_OFF	1L
+# define PR_RISCV_SCOPE_PER_PROCESS	0L
+# define PR_RISCV_SCOPE_PER_THREAD	1L
=20
 /* PowerPC Dynamic Execution Control Register (DEXCR) controls */
 #define PR_PPC_GET_DEXCR		72
 #define PR_PPC_SET_DEXCR		73
 /* DEXCR aspect to act on */
-# define PR_PPC_DEXCR_SBHE		0 /* Speculative branch hint enable */
-# define PR_PPC_DEXCR_IBRTPD		1 /* Indirect branch recurrent target predic=
tion disable */
-# define PR_PPC_DEXCR_SRAPD		2 /* Subroutine return address prediction dis=
able */
-# define PR_PPC_DEXCR_NPHIE		3 /* Non-privileged hash instruction enable */
+# define PR_PPC_DEXCR_SBHE		0L /* Speculative branch hint enable */
+# define PR_PPC_DEXCR_IBRTPD		1L /* Indirect branch recurrent target predi=
ction disable */
+# define PR_PPC_DEXCR_SRAPD		2L /* Subroutine return address prediction di=
sable */
+# define PR_PPC_DEXCR_NPHIE		3L /* Non-privileged hash instruction enable =
*/
 /* Action to apply / return */
 # define PR_PPC_DEXCR_CTRL_EDITABLE	 0x1 /* Aspect can be modified with PR=
_PPC_SET_DEXCR */
 # define PR_PPC_DEXCR_CTRL_SET		 0x2 /* Set the aspect for this process */
--=20
2.45.1


--chovke2wgn4y6l4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZVxHYACgkQnowa+77/
2zJlDw/9GzVJ4yaeuxhOXXKagOO+zIO+KPoixCtN3pbiBPawlIhtOE3LT8hlJp8X
mX6YDGqw2GTyrZ4a3oyRma31e+uqeRX5se9jIDHoh6GZDqYENb6btg62oPM8Wxuy
dBMwSqD4nZC6lVcfPtxsVgQZdXHghpR3dxqbQcZMBeYr5Dc3Y23XfP4BCKIAtjrW
Gx1ZsruwBitapT6z8wlx9xHjou4eMoxGUMNmcxqrVsAlslh/pfitOJ+pVqW0XrsE
yQ5b2mhDXNQg+p78m7yWQXZahCI8ZRKgFpoIvAdS8uA7Gr/zmrRSb+ctS7TtDyBW
loW/mk7+av8JZLd21ROfKNJdxtK/XEDcEsyGanxjMj0ALeiejkSc/LXB7lvtfQ3f
ivTUgj5HgVGAPSgIRzsJjrJ2RGlpazJto1XSGOYKvqv0UhssfviM2pIgM54fgs4t
aFwy0MejnhOXwz/Y3AAm2pQvM6fNhUh2B7WO+2CRXZcJ57/D5KVbYZx5lH8FnRs/
qVf3GoOuhVbzw7TV2mpwMoWgYKw9x65j8s/jvtTnBR+dBZGLUfTmXdxrWbBt8E2v
4i0raVfxJmKkYVmzc7kEHRNUuBgSlGVsGTUaAkLSt6vFLpTLWvomC5yJJw2EDBJP
lDz0scLjxQUoRYEj1VZqTBTnQIVwK3kC5T0Y9GP9bFQiBdm71c4=
=bTYn
-----END PGP SIGNATURE-----

--chovke2wgn4y6l4e--

