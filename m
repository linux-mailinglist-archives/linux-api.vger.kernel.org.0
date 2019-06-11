Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C598418B8
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 01:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404483AbfFKXQg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Jun 2019 19:16:36 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:53658 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728264AbfFKXQg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 11 Jun 2019 19:16:36 -0400
X-Greylist: delayed 2257 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2019 19:16:33 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GNE12vQTu4aqIFz7FyS4G9Pynhm5PGQdn9SLZmRERIA=; b=DtMEEeQVg/nre/6c89QcIuZG3q
        /OB432/WUa4/x1RpAJ3mfYr/IJD0WpsHGCTToAUu8yIrHJm8hpBCdOI8F6PgXoiwhym3qM6ohbsU3
        cz3zeVleCSw9fbjZLE7EuglmOOHOkbCQgdmC4GL/GTp1KJaCUJaSLDQymsR/+vS55t27KcnEwHzLx
        rJMAHTC4V0f0uwKxiDaswdS+giqFcpyb3ymfVXEYQ76OXg7H7B71EZZvhL52w4QvcPMSM4Us8NOhS
        Hg9SZqfCFFmNSGEMDq3Klfb38pvpIm4VM28BqmsPBDXCgwMPv4RVs2VwHNUbIg7eudzR/QutapgAu
        O/k0tEqg==;
Received: from [37.204.119.143] (port=45300 helo=cello)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1hapPC-000Kcl-Qe; Wed, 12 Jun 2019 01:38:15 +0300
Date:   Wed, 12 Jun 2019 01:38:06 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Vladimir D . Seleznev" <vseleznv@altlinux.org>,
        linux-api@vger.kernel.org
Message-ID: <20190611223806.GA1112@cello>
References: <20190605081906.28938-1-ar@cs.msu.ru>
 <20190605081906.28938-2-ar@cs.msu.ru>
 <87o933507j.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <87o933507j.fsf@xmission.com>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.cs.msu.ru
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_ADSP_ALL autolearn=no autolearn_force=no version=3.4.2
Subject: Re: [PATCH 1/7] signal.h: Define SIGINFO on all architectures
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2019 at 03:36:00PM -0500, Eric W. Biederman wrote:
> Arseny Maslennikov <ar@cs.msu.ru> writes:
>=20
> > This complementary patch defines SIGINFO as a synonym for SIGPWR
> > on every architecture supported by the kernel.
> > The particular signal number chosen does not really matter and is only
> > required for the related tty functionality to work properly,
> > so if it does not suite expectations, any suggestions are warmly
> > welcome.
> >
> > SIGPWR looks like a nice candidate for this role, because it is
> > defined on every supported arch; it is currently only used to inform
> > PID 1 of power failures, and daemons that care about low-level
> > events do not tend to have a controlling terminal.
> >
> > However, on sparcs SIGPWR is a synonym for SIGLOST, a signal unique
> > to that architecture, with a narrow set of intended uses that do not
> > combine well with interactively requesting status.
> > SIGLOST is not used by any kernel code at the moment.
> > I'm not sure there is a more reasonable alternative right now.
>=20
> Is the name SIGINFO already well established.
>=20
> It just is a little bit confusing with struct siginfo.
>=20

I thought about this, but the alternatives are clunkier.
SIGKBINFO? Implies there actually is a keyboard, most ttys are
virtual/software nowadays. Misplaced emphasis.
SIGSTATUS? Too generic.
SIGTINFO? This could work, like conveys the nature and all, but many
applications already do #ifdef SIGINFO; if we reuse the name they will
suddenly just work, and this helps adoption.
SIGTINFO does decipher to "terminal info", this sounds too ambiguous.

Fortunately, from UNIX tradition signal names are defined in caps, and
given there is much more related written discussion than spoken, this
stands out enough to my taste. I'd say, it stands out a lot.

> At least on x86 it looks like we have signals 32 and 33 that are
> reserved and not used for anything.  Is there a reason you have
> not picked one of those?

Quoting signal(7) from man-pages:
       The Linux kernel supports a range of 33 different real-time
       signals, numbered 32  to  64.   However,  the  glibc  POSIX
       threads  implementation  internally  uses two (for NPTL) or
       three   (for   LinuxThreads)   real-time    signals    (see
       pthreads(7)),  and  adjusts  the value of SIGRTMIN suitably
       (to 34 or 35).

This excerpt gives the cue that signals 32 and 33 are not really unused,
and I did not want to cause further adjustments to SIGRTMIN/SIGRTMAX,
since this means we have to recompile the world with the new, changed
SIGRTMIN/MAX...

If we'd change RTMIN, this makes all the rt signal numbers shift to the
right and can cause havoc if we do not recompile the world.

We could probably go with decrementing RTMAX and reusing the value
(effectively reserving a signal number from the end), but aliasing PWR
seems much easier and less harmful, and easier for apps to adopt.
If we find a strong reason not to reuse PWR, this may be considered as a
plan B, but the idea to allocate even more precious signals seems too
wasteful to me for now.

>=20
> Also should this be a realtime signal with signal information
> or a non-realtime signal?

I see no requirement for this to be a realtime signal.

Non-realtime signals like PWR or INT also have at least some signal
information which can be accessed with handlers installed with
sigaction(2). [1] has a small example.
The most obvious piece of info is that signals sent by n_tty
(si_code=3D=3DSI_KERNEL) are easy to distinguish from signals sent by
processes (si_code=3D=3DSI_USER)

>=20
> I don't expect there is much to encode except that the user is asking
> for information.  I half wonder if it could be done as a different
> si_code to SIGWINCH.  But of course that doesn't work because it is
> not a real time signal so does not queue more than one siginfo. (Sigh).
>=20

Signals are just a huge mess (not that this is news...)  :)

> I just would like to see that we have a clear concept of how this new
> signal plays into all of the signal handling bits.
>=20
> Added linux-api because this is fundamentally extending the linux-api,
> and we probably want man-page updates etc.
>=20
> Eric
>=20

[1]https://github.com/porrided/tty-kb-status-userspace/blob/d32028056c85b27=
9cf8d5f43478b5419d090637c/siginfo-test/siginfo.c

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAl0ALUkACgkQ9dQjyAYL
01BW0hAAp16BV3hKnjc+iWwm3CkoMTcMZPMDaDJZmsfyjUIS1qqNiJ3NfKr/2LGv
C9A7sX3VKE0GXijjJvxxnyfVhKsamQ4m0vaJawhYPKcWj9BGVqZoAilEo5Lf4eV8
Mw2unvgdr0YW4aReAb83ocCYD1ZjqFy3VGz9uVZHx9tOCTGXiVT/gijiHuT9PV4G
iaO/SZW+CT1aZ6L0m7XDR78vPFuBLMrJmrBri5yd4LmvGS/A3ldsQA3QEY4v1Shc
usk7AV90llIuKCQCNDj3OLD8odeESSqefCdtAE39Zuaau9N/BqLsXe5h6qp37ZkB
vYsYkR1Bw9Pat5itTzuCNGnPtO4pSiPmnesQkKL2P5bxtUOl11BJCKCFei20O7yE
cQI91lPpcDZrBMWvxtDPUzemqhQxzPoUvI3XbVK8gogFmFsVrTeFc5IlCUf0j3Jr
JkTYbxWbtYf/MK+Pju2jxj5zcmlgVA8CFaF2sYB9BBHNGAnjZPdxJ1NmarHKc4f+
Z1EFGJasACMR1P3TVXV9sjqmBMUzlrgxPGvCqnc+7icXbKMaDc2Lm7cUJfGapGi1
zagyCvwkqJrPydKUgy753Cr8druVfT9jMfnCl/FoPhTpeXjTpbCawh0HAFjMK2JH
aEoNg2C6FwF6IzCMX2D6UGc2RNk9iMJTzvWsOxpvJ6W0L8VAMXk=
=73jc
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
