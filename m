Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097652159EE
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2020 16:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgGFOtn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Jul 2020 10:49:43 -0400
Received: from mail.efficios.com ([167.114.26.124]:57410 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgGFOtl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Jul 2020 10:49:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 63F692D8429;
        Mon,  6 Jul 2020 10:49:39 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nGbNS3E2RCRr; Mon,  6 Jul 2020 10:49:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 198852D8339;
        Mon,  6 Jul 2020 10:49:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 198852D8339
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594046979;
        bh=8gAqoabmX0YflNXKWP2tfZI2xQ9rxWmk8Vog6l1Uejc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=rxQ/oIwF2PU+6lDE1w7+Geq7Z0Y1xfBDUbTcERHIo8TBUptlVm2rd7oeSbrLdHCZ+
         ycEdmDsAdFEno27tUxe+lyUxu0o935KL5RsDp4TvSOQ05IlqyuoVBrMzs2NKC7l2Q/
         SFlFR30T0hgUDcvu8OqLfgiql/gHSPtifh5np5FBsqZ6jJSsQGBEPj5D46SyW67wZR
         DevmD+6sNIni81jClilhGrBOw1/eYObNrxmpP9rHFBPzlgmiHudybM7kgpVVJe6UiZ
         ac1X8F0DLGYAx3kLn52tuS0WeG7/Fc1/kdVE8aeIwSNsTaDW28Y28ILjwgvTB8U8tE
         Wqdpb23RS1fkg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FXEvtcbaTxen; Mon,  6 Jul 2020 10:49:39 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 094812D8338;
        Mon,  6 Jul 2020 10:49:39 -0400 (EDT)
Date:   Mon, 6 Jul 2020 10:49:38 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <942999672.22574.1594046978937.JavaMail.zimbra@efficios.com>
In-Reply-To: <877dvg4ud4.fsf@oldenburg2.str.redhat.com>
References: <20200629190036.26982-1-mathieu.desnoyers@efficios.com> <20200629190036.26982-3-mathieu.desnoyers@efficios.com> <877dvg4ud4.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 2/3] Linux: Use rseq in sched_getcpu if available (v9)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3928)
Thread-Topic: Linux: Use rseq in sched_getcpu if available (v9)
Thread-Index: s+lDRWKNxhAkUDtcGJ1GCFO2e2bJlg==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 6, 2020, at 9:59 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
>=20
>> When available, use the cpu_id field from __rseq_abi on Linux to
>> implement sched_getcpu().  Fall-back on the vgetcpu vDSO if
>> unavailable.
>=20
> I've pushed this to glibc master, but unfortunately it looks like this
> exposes a kernel bug related to affinity mask changes.
>=20
> After building and testing glibc, this
>=20
>  for x in {1..2000} ; do posix/tst-affinity-static  & done
>=20
> produces some =E2=80=9Cerror:=E2=80=9D lines for me:
>=20
> error: Unexpected CPU 2, expected 0
> error: Unexpected CPU 2, expected 0
> error: Unexpected CPU 2, expected 0
> error: Unexpected CPU 2, expected 0
> error: Unexpected CPU 138, expected 0
> error: Unexpected CPU 138, expected 0
> error: Unexpected CPU 138, expected 0
> error: Unexpected CPU 138, expected 0
>=20
> =E2=80=9Cexpected 0=E2=80=9D is a result of how the test has been written=
, it bails out
> on the first failure, which happens with CPU ID 0.
>=20
> Smaller systems can use a smaller count than 2000 to reproduce this.  It
> also happens sporadically when running the glibc test suite itself
> (which is why it took further testing to reveal this issue).
>=20
> I can reproduce this with the Debian 4.19.118-2+deb10u1 kernel, the
> Fedora 5.6.19-300.fc32 kernel, and the Red Hat Enterprise Linux kernel
> 4.18.0-193.el8 (all x86_64).
>=20
> As to the cause, I'd guess that the exit path in the sched_setaffinity
> system call fails to update the rseq area, so that userspace can observe
> the outdated CPU ID there.

Hi Florian,

We have a similar test in Linux, see tools/testing/selftests/rseq/basic_tes=
t.c.
That test does not trigger this issue, even when executed repeatedly.

I'll investigate further what is happening within the glibc test.

Thanks,

Mathieu


--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
