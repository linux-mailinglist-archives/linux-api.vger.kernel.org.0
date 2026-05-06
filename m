Return-Path: <linux-api+bounces-6273-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HHQCztU+2n+ZQMAu9opvQ
	(envelope-from <linux-api+bounces-6273-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 06 May 2026 16:46:19 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2244DC82D
	for <lists+linux-api@lfdr.de>; Wed, 06 May 2026 16:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FD21300998A
	for <lists+linux-api@lfdr.de>; Wed,  6 May 2026 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440AC453497;
	Wed,  6 May 2026 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nzT/+nb3"
X-Original-To: linux-api@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54920423176;
	Wed,  6 May 2026 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078563; cv=none; b=rrMN+uoDY7SDPVv/xAke5uR0IkKxjrhI7d6QfyoGNFMw8mUCsvXcRLii5c4sxRczhjmhz3CUsjP5fGvFISJ1peNs6CyEYhNLoC/G2BklAEul042gS6yLgZBsNp7i/JBI9muStcTLUeLbeTXZ/KpuvYzYqI+6H7EIGh0zREMwSfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078563; c=relaxed/simple;
	bh=oEjGrkm85m4UCUmN+tq5hKgVlKjP1DK7bgtzszcGICE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Disposition; b=O4lwrN48Ugj8bZXHwoOyL+tPCtEz8+zxJXNdTTJk6Ho06uNoujym3IesGh8rg7W/3YWQrPODqpRoLPhyQayH4rPU9jBewi+HhTtnsr43QSxD1PAhcraZ28mMg6+JmMTyvrqwatQ3luHuBxDoSDI6PwOy15r/b++2g91En7Lm2cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nzT/+nb3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i (unknown [52.177.6.131])
	by linux.microsoft.com (Postfix) with ESMTPSA id C772320B7165;
	Wed,  6 May 2026 07:42:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C772320B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778078552;
	bh=Pv1lMoxjQy4DDl27TX7Hfog87twEx3siikQJCVpCXHg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nzT/+nb3SK+81p1Ya/pp1p5nTNprqfmoj0h78JoPVZd8I4DE/Ezx4Tb16INV5jRU2
	 KQ5/XM1pGOu87G075JwUpUQq9RR2PLKn+SfAC2lbFQpMmGAq4GnbxdsmE/INRIcRpz
	 NlDFdtpUNj5EFgdzwRj8jPNbaUfbsApmLXy9L2Gw=
Date: Wed, 6 May 2026 10:42:31 -0400
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Eric Biggers <ebiggers@kernel.org>, 
 "=?utf-8?Q?linux-crypto=40vger.kernel.org?="
 <linux-crypto@vger.kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, "=?utf-8?Q?linux-doc=40vger.kernel.org?="
 <linux-doc@vger.kernel.org>, "=?utf-8?Q?linux-api=40vger.kernel.org?="
 <linux-api@vger.kernel.org>, 
 "=?utf-8?Q?linux-kernel=40vger.kernel.org?="
 <linux-kernel@vger.kernel.org>, "=?utf-8?Q?netdev=40vger.kernel.org?="
 <netdev@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Message-ID: <14A441D8-5370-44BE-8732-99BF8107C3FD@getmailspring.com>
In-Reply-To: <CALCETrVqG+1yErRJjkxvJrf=A+Vu84HTR4Bx1Pcd8G1C0PJcMA@mail.gmail.com>
References: <CALCETrVqG+1yErRJjkxvJrf=A+Vu84HTR4Bx1Pcd8G1C0PJcMA@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
X-Mailer: Mailspring
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Rspamd-Queue-Id: DF2244DC82D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.95 / 15.00];
	CC_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-6273-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffbarnes@linux.microsoft.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]

Hi,

On May 5 2026, at 7:17 pm, Andy Lutomirski <luto=40amacapital.net> wrote:=


>> On Apr 29, 2026, at 6:19=E2=80=AFPM, Eric Biggers <ebiggers=40kernel.o=
rg> wrote:
>> =20
>> =EF=BB=BFA=46=5FALG is almost completely unnecessary, and it exposes a=
 massive attack
>> surface that hasn't been standing up to modern vulnerability discovery=

>> tools.  The latest one even has its own website, providing a small
>> Python script that reliably roots most Linux distros: https://copy.fai=
l/
> =20
> How about adding a configuration option, defaulted on, that requires
> capable(CAP=5FSYS=5FADMIN) to create the socket (and maybe also to bind=
 /
> connect it).  And a sysctl to allow the administrator to override this
> in the unlikely event that it=E2=80=99s needed.
> =20
> IIRC cryptsetup used to and maybe even still does require these
> sockets sometimes and this would let it keep working.  And there's all
> the =46IPS stuff downthread.

Apologize in advance for the long-winded answer.

The =22=46IPS stuff=22 centers on using sha512hmac -> libkcapi -> A=46=5F=
ALG for
verifying integrity. The early=E2=80=91boot sha512hmac check that some
distributions use (typically from initramfs) sits at an awkward
intersection of multiple standards, and it may help to clarify where it
actually fits and where it doesn't.

=46rom a standards perspective, =46IPS=E2=80=AF140=E2=80=913 requires a c=
ryptographic module
to perform self=E2=80=91integrity verification using an approved algorith=
m and
to prevent the module from entering an operational state on failure. In
the Linux kernel, the cryptographic module is the kernel crypto
subsystem, and these requirements are met by the kernel=E2=80=99s interna=
l
power=E2=80=91up self=E2=80=91tests (KATs, etc.) on the crypto code and c=
ritical data as
loaded into memory.

=46IPS=E2=80=AF199 / SP=E2=80=AF800=E2=80=9153 (e.g., SI=E2=80=917) impos=
e system=E2=80=91level integrity
requirements (for Moderate impact systems), i.e., that unauthorized
modification of critical components is prevented or detected and that
failures result in a protective action. These controls are explicitly
technology=E2=80=91agnostic and are not limited to cryptographic=E2=80=91=
module self=E2=80=91tests.

The sha512hmac check is not the =46IPS=E2=80=AF140=E2=80=913 cryptographi=
c=E2=80=91module
self=E2=80=91integrity test. Instead, it has historically been used as a =
system
integrity control that provides auditors with assurance that the kernel
image containing the cryptographic module has not been modified prior to
execution, and that a failure will halt the boot.

Although =46IPS=E2=80=AF140=E2=80=913 does not mandate an HMAC over the k=
ernel image, the
early=E2=80=91boot HMAC became an accepted evidence pattern for satisfyin=
g
system=E2=80=91integrity expectations (=46IPS=E2=80=AF199 / SI=E2=80=917)=
 alongside a kernel
crypto validation. This is why it is often perceived as =E2=80=9Crequired=
=E2=80=9D for
=46IPS submissions, even though it is not normatively required by
=46IPS=E2=80=AF140=E2=80=913 itself.

With the deprecation/removal of A=46=5FALG for this use case, there is no=

longer a supported way to perform an early=E2=80=91boot, userspace=E2=80=91=
driven HMAC
using validated kernel crypto without introducing circular dependencies
(e.g., relying on userspace crypto before crypto self=E2=80=91tests compl=
ete).
As a result, there is no drop=E2=80=91in replacement for sha512hmac that
preserves all of its historical properties.

This is a new development that challenges a long=E2=80=91standing assumpt=
ion:
that system=E2=80=91integrity evidence and cryptographic=E2=80=91module s=
elf=E2=80=91integrity
can be cleanly separated while still being demonstrated by a single
early=E2=80=91boot mechanism. That assumption no longer holds given propo=
sed
kernel interfaces.

A more accurate decomposition (and one that aligns with the intent of
the standards) is to separate integrity enforcement by system phase.

1. Secure Boot (or equivalent platform verification) ensures that a
modified kernel image is not executed at all. This satisfies the
requirement that critical components are not loaded in a modified state
and that integrity failure results in a protective action (boot preventio=
n).

2. IMA (with appraisal and enforcement) ensures that modified
executables, modules, or firmware cannot be loaded or executed once the
kernel is running.

3. Kernel crypto self=E2=80=91tests continue to satisfy =46IPS=E2=80=AF14=
0=E2=80=913
self=E2=80=91integrity requirements independently of the above.

Taken together, Secure Boot + IMA provide continuous system=E2=80=91integ=
rity
enforcement without re=E2=80=91introducing early=E2=80=91boot HMACs or A=46=
=5FALG
dependencies, while keeping cryptographic=E2=80=91module self=E2=80=91int=
egrity
correctly scoped to the kernel crypto subsystem.

The transition away from sha512hmac is therefore not a removal of
integrity enforcement, but a shift from a single, early=E2=80=91boot mech=
anism
to a phased integrity model that better reflects the separation of
concerns already present in the standards =E2=80=94 even though this sepa=
ration
was previously masked by the hacky HMAC approach.

This change will require updated documentation and auditor education,
but it reflects the current technical reality and avoids perpetuating an
interface that no longer has a sustainable implementation path.

> =20
> =20
>> =20
>> This isn't sustainable, especially as LLMs have accelerated the rate t=
he
>> vulnerabilities are coming in.  The effort that is being put into this=

>> thing is vastly disproportional to the few programs that actually use
>> it, and those programs would be better served by userspace code anyway=
.
>> =20
>> These issues have been noted in many mailing list discussions already.=

>> But until now they haven't been reflected in the documentation or
>> kconfig menu itself, and the vulnerabilities are still coming in.
>> =20
>> Let's go ahead and document the deprecation.
>> =20
>> This isn't intended to change anything overnight.  After all, most Lin=
ux
>> distros won't be able to disable the kconfig options quite yet, mainly=

>> because of iwd.  But this should create a bit more impetus for these
>> userspace programs to be fixed, and the documentation update should al=
so
>> help prevent more users from appearing.
>> =20
>> Signed-off-by: Eric Biggers <ebiggers=40kernel.org>
>> ---
>> =20
>> This patch is targeting crypto/master
>> =20
>> Documentation/crypto/userspace-if.rst =7C 82 ++++++++++++++++++++-----=
--
>> crypto/Kconfig                        =7C 69 ++++++++++++++++------
>> 2 files changed, 113 insertions(+), 38 deletions(-)
>> =20
>> diff --git a/Documentation/crypto/userspace-if.rst b/Documentation/cry=
pto/userspace-if.rst
>> index 021759198fe7..c39f5c79a5b7 100644
>> --- a/Documentation/crypto/userspace-if.rst
>> +++ b/Documentation/crypto/userspace-if.rst
>> =40=40 -2,30 +2,72 =40=40 User Space Interface
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =20
>> Introduction
>> ------------
>> =20
>> -The concepts of the kernel crypto API visible to kernel space is full=
y
>> -applicable to the user space interface as well. Therefore, the kernel=

>> -crypto API high level discussion for the in-kernel use cases applies
>> -here as well.
>> -
>> -The major difference, however, is that user space can only act as a
>> -consumer and never as a provider of a transformation or cipher
>> -algorithm.
>> -
>> -The following covers the user space interface exported by the kernel
>> -crypto API. A working example of this description is libkcapi that ca=
n
>> -be obtained from =5B1=5D. That library can be used by user space
>> -applications that require cryptographic services from the kernel.
>> -
>> -Some details of the in-kernel kernel crypto API aspects do not apply =
to
>> -user space, however. This includes the difference between synchronous=

>> -and asynchronous invocations. The user space API call is fully
>> -synchronous.
>> -
>> -=5B1=5D https://www.chronox.de/libkcapi/index.html
>> +A=46=5FALG provides unprivileged userspace programs access to arbitra=
ry hash,
>> +symmetric cipher, AEAD, and RNG algorithms that are implemented in ke=
rnel-mode
>> +code.
>> +
>> +A=46=5FALG is insecure and is deprecated. Originally added to the ker=
nel
>> in 2010,
>> +most kernel developers now consider it to be a mistake.
>> +
>> +A=46=5FALG continues to be supported only for backwards compatibility=
.
>> On systems
>> +where no programs using A=46=5FALG remain, the support for it should =
be
>> disabled by
>> +disabling =60=60CON=46IG=5FCRYPTO=5FUSER=5FAPI=5F*=60=60.
>> +
>> +Deprecation
>> +-----------
>> +
>> +A=46=5FALG was originally intended to provide userspace programs acce=
ss
>> to crypto
>> +accelerators that they wouldn't otherwise have access to.
>> +
>> +However, that capability turned out to not be useful on very many
>> systems. More
>> +significantly, the actual implementation exposes a vastly greater
>> amount of
>> +functionality than that. It actually provides access to all software =
algorithms.
>> +
>> +This includes arbitrary compositions of different algorithms created
>> via a
>> +complex template system, as well as algorithms that only make sense
>> as internal
>> +implementation details of other algorithms. It also includes full zer=
o-copy
>> +support, which is difficult for the kernel to implement securely.
>> +
>> +Ultimately, these algorithms are just math computations. They use
>> the same
>> +instructions that userspace programs already have access to, just
>> accessed in a
>> +much more convoluted and less efficient way.
>> +
>> +Indeed, userspace code is nearly always what is being used anyway.
>> These same
>> +algorithms are widely implemented in userspace crypto libraries.
>> +
>> +Meanwhile, A=46=5FALG hasn't been withstanding modern vulnerability
>> discovery tools
>> +such as syzbot and large language models. It receives a steady
>> stream of CVEs.
>> +Some of the examples include:
>> +
>> +- CVE-2026-31677
>> +- CVE-2026-31431 (https://copy.fail)
>> +- CVE-2025-38079
>> +- CVE-2025-37808
>> +- CVE-2024-26824
>> +- CVE-2022-48781
>> +- CVE-2019-8912
>> +- CVE-2018-14619
>> +- CVE-2017-18075
>> +- CVE-2017-17806
>> +- CVE-2017-17805
>> +- CVE-2016-10147
>> +- CVE-2015-8970
>> +- CVE-2015-3331
>> +- CVE-2014-9644
>> +- CVE-2013-7421
>> +- CVE-2011-4081
>> +
>> +It is recommended that, whenever possible, userspace programs be
>> migrated to
>> +userspace crypto code (which again, is what is normally used anyway) =
and
>> +=60=60CON=46IG=5FCRYPTO=5FUSER=5FAPI=5F*=60=60 be disabled.  On syste=
ms that use
>> SELinux, SELinux
>> +can also be used to restrict the use of A=46=5FALG to trusted program=
s.
>> +
>> +The remainder of this documentation provides the historical
>> documentation for
>> +the deprecated A=46=5FALG interface.
>> =20
>> User Space API General Remarks
>> ------------------------------
>> =20
>> The kernel crypto API is accessible from user space. Currently, the
>> diff --git a/crypto/Kconfig b/crypto/Kconfig
>> index 103d1f58cb7c..6cd1c478d4be 100644
>> --- a/crypto/Kconfig
>> +++ b/crypto/Kconfig
>> =40=40 -1278,48 +1278,72 =40=40 config CRYPTO=5FD=4680090A
>>    tristate
>>    select CRYPTO=5FAES
>>    select CRYPTO=5FCTR
>> =20
>> endmenu
>> -menu =22Userspace interface=22
>> +menu =22Userspace interface (deprecated)=22
>> =20
>> config CRYPTO=5FUSER=5FAPI
>>    tristate
>> =20
>> config CRYPTO=5FUSER=5FAPI=5FHASH
>> -    tristate =22Hash algorithms=22
>> +    tristate =22Hash algorithms (deprecated)=22
>>    depends on NET
>>    select CRYPTO=5FHASH
>>    select CRYPTO=5FUSER=5FAPI
>>    help
>> -      Enable the userspace interface for hash algorithms.
>> +      Enable the A=46=5FALG userspace interface for hash algorithms. =
 This
>> +      provides unprivileged userspace programs access to arbitrary ha=
sh
>> +      algorithms implemented in the kernel's privileged execution con=
text.
>> =20
>> -      See Documentation/crypto/userspace-if.rst and
>> -      https://www.chronox.de/libkcapi/html/index.html
>> +      This interface is deprecated and is supported only for backward=
s
>> +      compatibility.  It regularly has vulnerabilities, and the capab=
ilities
>> +      it provides are redundant with userspace crypto libraries.
>> +
>> +      Enable this only if needed for support for a program that
>> hasn't yet
>> +      been converted to userspace crypto, for example iwd.
>> +
>> +      See also Documentation/crypto/userspace-if.rst
>> =20
>> config CRYPTO=5FUSER=5FAPI=5FSKCIPHER
>> -    tristate =22Symmetric key cipher algorithms=22
>> +    tristate =22Symmetric key cipher algorithms (deprecated)=22
>>    depends on NET
>>    select CRYPTO=5FSKCIPHER
>>    select CRYPTO=5FUSER=5FAPI
>>    help
>> -      Enable the userspace interface for symmetric key cipher algorit=
hms.
>> +      Enable the A=46=5FALG userspace interface for symmetric key alg=
orithms.
>> +      This provides unprivileged userspace programs access to arbitra=
ry
>> +      symmetric key algorithms implemented in the kernel's privileged=

>> +      execution context.
>> +
>> +      This interface is deprecated and is supported only for backward=
s
>> +      compatibility.  It regularly has vulnerabilities, and the capab=
ilities
>> +      it provides are redundant with userspace crypto libraries.
>> +
>> +      Enable this only if needed for support for a program that
>> hasn't yet
>> +      been converted to userspace crypto, for example iwd, or cryptse=
tup
>> +      with certain algorithms.
>> =20
>> -      See Documentation/crypto/userspace-if.rst and
>> -      https://www.chronox.de/libkcapi/html/index.html
>> +      See also Documentation/crypto/userspace-if.rst
>> =20
>> config CRYPTO=5FUSER=5FAPI=5FRNG
>> -    tristate =22RNG (random number generator) algorithms=22
>> +    tristate =22Random number generation algorithms (deprecated)=22
>>    depends on NET
>>    select CRYPTO=5FRNG
>>    select CRYPTO=5FUSER=5FAPI
>>    help
>> -      Enable the userspace interface for RNG (random number generator=
)
>> -      algorithms.
>> +      Enable the A=46=5FALG userspace interface for random number gen=
eration
>> +      (RNG) algorithms.  This provides unprivileged userspace program=
s
>> +      access to arbitrary RNG algorithms implemented in the kernel's
>> +      privileged execution context.
>> =20
>> -      See Documentation/crypto/userspace-if.rst and
>> -      https://www.chronox.de/libkcapi/html/index.html
>> +      This interface is deprecated and is supported only for backward=
s
>> +      compatibility.  It regularly has vulnerabilities, and the capab=
ilities
>> +      it provides are redundant with userspace crypto libraries as
>> well as
>> +      the normal kernel RNG (e.g., /dev/urandom and getrandom(2)).
>> +
>> +      See also Documentation/crypto/userspace-if.rst
>> =20
>> config CRYPTO=5FUSER=5FAPI=5FRNG=5FCAVP
>>    bool =22Enable CAVP testing of DRBG=22
>>    depends on CRYPTO=5FUSER=5FAPI=5FRNG && CRYPTO=5FDRBG
>>    help
>> =40=40 -1330,20 +1354,29 =40=40 config CRYPTO=5FUSER=5FAPI=5FRNG=5FCAV=
P
>> =20
>>      This should only be enabled for CAVP testing. You should say
>>      no unless you know what this is.
>> =20
>> config CRYPTO=5FUSER=5FAPI=5FAEAD
>> -    tristate =22AEAD cipher algorithms=22
>> +    tristate =22AEAD cipher algorithms (deprecated)=22
>>    depends on NET
>>    select CRYPTO=5FAEAD
>>    select CRYPTO=5FSKCIPHER
>>    select CRYPTO=5FUSER=5FAPI
>>    help
>> -      Enable the userspace interface for AEAD cipher algorithms.
>> +      Enable the A=46=5FALG userspace interface for authenticated enc=
ryption
>> +      with associated data (AEAD) algorithms.  This provides unprivil=
eged
>> +      userspace programs access to arbitrary AEAD algorithms
>> implemented in
>> +      the kernel's privileged execution context.
>> +
>> +      This interface is deprecated and is supported only for backward=
s
>> +      compatibility.  It regularly has vulnerabilities, and the capab=
ilities
>> +      it provides are redundant with userspace crypto libraries.
>> +
>> +      Enable this only if needed for support for a program that
>> hasn't yet
>> +      been converted to userspace crypto, for example iwd.
>> =20
>> -      See Documentation/crypto/userspace-if.rst and
>> -      https://www.chronox.de/libkcapi/html/index.html
>> +      See also Documentation/crypto/userspace-if.rst
>> =20
>> config CRYPTO=5FUSER=5FAPI=5FENABLE=5FOBSOLETE
>>    bool =22Obsolete cryptographic algorithms=22
>>    depends on CRYPTO=5FUSER=5FAPI
>>    default y
>> =20
>> base-commit: 57b8e2d666a31fa201432d58f5fe3469a0dd83ba
>> --
>> 2.54.0
>> =20
>> =20
> 

