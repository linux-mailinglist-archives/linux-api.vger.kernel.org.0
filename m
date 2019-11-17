Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 947E2FF959
	for <lists+linux-api@lfdr.de>; Sun, 17 Nov 2019 13:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfKQMRd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 Nov 2019 07:17:33 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:32966 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfKQMRd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 Nov 2019 07:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573993051;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=bCbsv9teHF57DwmEXM3joJCcJL2jsW51I59cUFXI/lI=;
        b=N7qyLRPPKqheFEdi1f25OoQrsvSBIZ3wfMA9xkyNvsjZfQ3/hY6/TRqoi3Ve70TgzI
        ML4G9Dr/OFKYud7rfpUaMCOQp/2VSnkKZZpZGMjQbFMuS+EWDSJAiLfUJU9TSsyuvGEJ
        fxRF0uZmFc13oiWKKKPLTR05+K2vZFzi979OEG2SY9kAiPh4OVhNqeP7E8e8y3yYPbQx
        7yMl5N+rL8Nz4TSUrP+lppJ587fQqgI/A0TS/4XcZzxvYzWjJGCfRuokBE4TX/jdbiBU
        LJAcZ6K0MaF5TUT2sv7/nK/bpTWJeblH5SbwQtfHoRCQuHrfAMXgM3FLdsQ9g50zvoaX
        gIOQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDbIvSfb0y2"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vAHCGJVZk
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 17 Nov 2019 13:16:19 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH v25 03/12] LRNG - /proc interface
Date:   Sun, 17 Nov 2019 13:16:19 +0100
Message-ID: <3043322.Kq9igzfA0K@positron.chronox.de>
In-Reply-To: <4EB89769-7A2C-4A03-A832-9A0539DD3336@amacapital.net>
References: <2476454.l8LQlgn7Hv@positron.chronox.de> <4EB89769-7A2C-4A03-A832-9A0539DD3336@amacapital.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Samstag, 16. November 2019, 17:39:40 CET schrieb Andy Lutomirski:

Hi Andy,

> > On Nov 16, 2019, at 1:40 AM, Stephan M=C3=BCller <smueller@chronox.de> =
wrote:
> >=20
> > =EF=BB=BFThe LRNG /proc interface provides the same files as the legacy
> > /dev/random. These files behave identically. Yet, all files are
> > documented at [1].
>=20
> Why?

I am not sure here: are you referring to the documentation? Or the one=20
additional file?

If it is the documentation, do you want me to add it to the patch descripti=
on?=20
I initially did not add it as these files were present and seemingly known=
=20
what they provide. But I would add that documentation to the patch descript=
ion=20
if this is desired.

If it is the additional file, should I move it to another place like a sysf=
s=20
interface?

Thank you.

Ciao
Stephan


