Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC262BDF70
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 15:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407044AbfIYNvn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 09:51:43 -0400
Received: from mailout.enyo.de ([116.203.30.208]:50645 "EHLO mailout.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406005AbfIYNvm (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 25 Sep 2019 09:51:42 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iD7he-0001T4-DB; Wed, 25 Sep 2019 13:51:34 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iD7he-0006xX-93; Wed, 25 Sep 2019 15:51:34 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: For review: pidfd_send_signal(2) manual page
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
        <87pnjr9rth.fsf@mid.deneb.enyo.de>
        <20190923142325.jowzbnwjw7g7si7j@wittgenstein>
        <90dd38d5-34b3-b72f-8e5a-b51f944f22fb@gmail.com>
        <20190924195701.7pw2olbviieqsg5q@wittgenstein>
        <b76adb4c-826b-6493-ba75-a9863066d3b1@gmail.com>
        <20190924215316.gxev2anuqffegocw@wittgenstein>
        <331cc245-3f70-dd43-31f9-8c1680ca6b20@gmail.com>
Date:   Wed, 25 Sep 2019 15:51:34 +0200
In-Reply-To: <331cc245-3f70-dd43-31f9-8c1680ca6b20@gmail.com> (Michael
        Kerrisk's message of "Wed, 25 Sep 2019 15:46:26 +0200")
Message-ID: <87h850scux.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Michael Kerrisk:

>        If these conditions don't hold true, then the child process should
>        instead be created using clone(2) with the CLONE_PID flag.

I think this should be CLONE_PIDFD.
