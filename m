Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94342B6F1B
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 20:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgKQTp0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 14:45:26 -0500
Received: from albireo.enyo.de ([37.24.231.21]:49990 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730548AbgKQTpX (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 17 Nov 2020 14:45:23 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kf6uj-0003DJ-At; Tue, 17 Nov 2020 19:45:17 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1kf6uj-0004gR-70; Tue, 17 Nov 2020 20:45:17 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Oskolkov <posk@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: Is adding an argument to an existing syscall okay?
References: <CALCETrXU2KcH0nsH_vd-fmvpZt_yW2+=VnYtN_BQJ6xsSvm+6A@mail.gmail.com>
        <87k0uj6h03.fsf@mid.deneb.enyo.de>
        <20201117183652.GD2672@gate.crashing.org>
        <87r1or4yct.fsf@mid.deneb.enyo.de>
        <CAPNVh5d2u84t9RV7kg6PYJc5eGFrEQV__aDX6AC2V4-s+msFvA@mail.gmail.com>
        <1828724974.48168.1605640886598.JavaMail.zimbra@efficios.com>
Date:   Tue, 17 Nov 2020 20:45:17 +0100
In-Reply-To: <1828724974.48168.1605640886598.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Tue, 17 Nov 2020 14:21:26 -0500
        (EST)")
Message-ID: <87ima34vjm.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> In some sense, it's a good thing that there isn't such wrapper exposed
> yet. It also makes me wonder whether exposing system calls directly as a
> library ABI is a good thing. It appears that library ABIs have stronger
> restrictions with respect to number and types of parameters than system
> calls.

The generic syscall wrapper function cannot be used to call all system
calls on several architectures (e.g., if the kernel ABI has long as 64
bits, userspace has 32 bits, and the syscall function is *required* to
return a long value, not long long).  It may also be difficult to get
the argument promotion correctly.  _time64-only architectures have
source code impact even if time is not actually used in the call.  And
so on.

A wrapper-less approach is possible, I think, even with C.  But I do
not think that userspace source code portability without wrappers has
been a concern for system call design so far.  It's a very constrained
space already, so I'm not sure if it's a good idea to add further
rules.
