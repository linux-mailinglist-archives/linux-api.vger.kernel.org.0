Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BF91C03B8
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 19:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgD3RUF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 13:20:05 -0400
Received: from mail.efficios.com ([167.114.26.124]:59474 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgD3RUE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Apr 2020 13:20:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D20BE290A16;
        Thu, 30 Apr 2020 13:20:03 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fTKELdeRdh4k; Thu, 30 Apr 2020 13:20:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 852BC290B08;
        Thu, 30 Apr 2020 13:20:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 852BC290B08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588267203;
        bh=Di5qGah5r+8XjpKMIa4fYVeZjc/aoZbDYSfzdYCDF9E=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=LLjA9fjLx88v78z9kHXBV3cIBVT6Ytx8fLd+ncdm/H4h0dOBMwGQQZkr1DNZs4w8Q
         ht+RcBbU/rWPTeeiy/8YEqPyj70VzUzeHFQMMcI591D522jKRMPgFZxCvpSBCuv9/A
         RJ/kD/p5uk5DkRtJdz+9YZkYWFIJyn0GWmxPbU27UhDVPeEryFAw2NBbM6J9nTzOEX
         7kziDXe0bAIiR+SFz6iyUlEAuM2neGIVXLX+aSc28ByC1BmTnEAhXz6BvxtOvR+7kZ
         ZaOeEUMAPzl7txUceVIFAbGMWu8WheV4EC+yTU5rvG2dh5A5XfCGL406IosNCED8X0
         HYZH7aQSoy9gw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4W0RDaxPKok7; Thu, 30 Apr 2020 13:20:03 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 679BE2904FA;
        Thu, 30 Apr 2020 13:20:03 -0400 (EDT)
Date:   Thu, 30 Apr 2020 13:20:03 -0400 (EDT)
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
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <729499446.78182.1588267203324.JavaMail.zimbra@efficios.com>
In-Reply-To: <874kt0lx6i.fsf@oldenburg2.str.redhat.com>
References: <20200428171513.22926-1-mathieu.desnoyers@efficios.com> <875zdhmaft.fsf@oldenburg2.str.redhat.com> <1287616647.77866.1588263099045.JavaMail.zimbra@efficios.com> <878sidkk0z.fsf@oldenburg2.str.redhat.com> <1972833271.77975.1588265754974.JavaMail.zimbra@efficios.com> <874kt0lx6i.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH glibc 1/3] glibc: Perform rseq(2) registration at C
 startup and thread creation (v18)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v18)
Thread-Index: ovrJOjNB9Oey32yCPILsJBJkjrvzzg==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Apr 30, 2020, at 1:07 PM, Florian Weimer fweimer@redhat.com wrote:
[...]
> __libc_fatal does not attribute the error to glibc, so I suggest to
> start the error messages with =E2=80=9Cglibc fatal error: =E2=80=9D, so t=
hat people know
> where to look.

OK. Is there a strict requirement on limiting to 80 columns for code
including an error message string in glibc ? IOW:

  if (__rseq_abi.cpu_id !=3D RSEQ_CPU_ID_UNINITIALIZED)
    __libc_fatal ("glibc fatal error: rseq already initialized for this thr=
ead\n");

or

  if (__rseq_abi.cpu_id !=3D RSEQ_CPU_ID_UNINITIALIZED)
    __libc_fatal ("glibc fatal error: "
                  "rseq already initialized for this thread\n");

?

Thanks,

Mathieu


--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
