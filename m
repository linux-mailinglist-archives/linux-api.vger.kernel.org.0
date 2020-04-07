Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD521A0F08
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2020 16:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgDGOTX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 7 Apr 2020 10:19:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47543 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgDGOTW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Apr 2020 10:19:22 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jLp4K-000768-PN; Tue, 07 Apr 2020 16:19:12 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 64BBF101303; Tue,  7 Apr 2020 16:19:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        Andrei Vagin <avagin@gmail.com>
Cc:     mtk.manpages@gmail.com, Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        linux-man <linux-man@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux API <linux-api@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Adrian Reber <adrian@lisas.de>
Subject: Re: RFC: time_namespaces(7) manual page
In-Reply-To: <fe940759-9159-5d89-1f5b-f92fa247177f@gmail.com>
References: <7221df0a-435b-f8bc-ff91-c188af535e73@gmail.com> <20200407032318.GA494464@gmail.com> <87r1wzk2p5.fsf@nanos.tec.linutronix.de> <fe940759-9159-5d89-1f5b-f92fa247177f@gmail.com>
Date:   Tue, 07 Apr 2020 16:19:12 +0200
Message-ID: <87lfn7js4f.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

"Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:
> I've tried to capture this info, as well some other relevant errors
> in the following text. Does it look okay?
>
>        Writes  to  the  timens_offsets  file  can fail with the following
>        errors:
>
>        EINVAL An offset-nanosecs value is greater than 999,999,999.
>
>        EINVAL A clock-id value is not valid.
>
>        EPERM  The caller does not have the the CAP_SYS_TIME capability.
>
>        ERANGE An offset-secs value is out of range.  In particular;
>
>               · offset-secs can't be set to a value which would make  the
>                 current time on the corresponding clock inside the names‐
>                 pace a negative value; and
>
>               · offset-secs can't be set to a value such that the time on
>                 the corresponding clock inside the namespace would exceed
>                 half of the value of the  kernel  constant  KTIME_SEC_MAX
>                 (this  limits  the  clock  value to a maximum of approxi‐
>                 mately 146 years).

Yes.

Thanks,

        tglx
