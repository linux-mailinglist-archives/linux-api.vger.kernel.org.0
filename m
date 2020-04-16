Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560A91ABD56
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2020 11:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504316AbgDPJwj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Apr 2020 05:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504220AbgDPJwd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Apr 2020 05:52:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1A0C061A0C;
        Thu, 16 Apr 2020 02:52:33 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jP1CA-0003Nz-7N; Thu, 16 Apr 2020 11:52:30 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 695D8100C51; Thu, 16 Apr 2020 11:52:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH v2] timens: show clock symbolic names in /proc/pid/timens_offsets
In-Reply-To: <20200416065648.GA801745@gmail.com>
References: <96bedbaf-49ea-f24b-b7b1-fb9a57fb6c7d@gmail.com> <20200411154031.642557-1-avagin@gmail.com> <20200416065648.GA801745@gmail.com>
Date:   Thu, 16 Apr 2020 11:52:29 +0200
Message-ID: <87pnc7n4f6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Andrei Vagin <avagin@gmail.com> writes:
> On Sat, Apr 11, 2020 at 08:40:31AM -0700, Andrei Vagin wrote:
>> Michael Kerrisk suggested to replace numeric clock IDs on symbolic
>> names.
>> 
>> Now the content of these files looks like this:
>> $ cat /proc/774/timens_offsets
>> monotonic      864000         0
>> boottime      1728000         0
>> 
>> For setting offsets, both representations of clocks can be used.
>> 
>> As for compatibility, it is acceptable to change things as long as
>> userspace doesn't care. The format of timens_offsets files is very
>> new and there are no userspace tools that rely on this format.
>> 
>> But three projects crun, util-linux and criu rely on the interface of
>> setting time offsets and this is why we need to continue supporting the
>> clock IDs in this case.
>> 
>> Fixes: 04a8682a71be ("fs/proc: Introduce /proc/pid/timens_offsets")
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
>> Acked-by: Michael Kerrisk <mtk.manpages@gmail.com>                                                                                                                                            
>
> Thomas and Andrew, could you merge this patch? I am sorry, I used the
> wrong subsystem prefix. Let me know if I need to send the third version
> of this patch.

Picking it up.
