Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885D47539E
	for <lists+linux-api@lfdr.de>; Thu, 25 Jul 2019 18:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389977AbfGYQNV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Jul 2019 12:13:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389184AbfGYQNV (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 25 Jul 2019 12:13:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CE2383F45;
        Thu, 25 Jul 2019 16:13:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id B62E310114A1;
        Thu, 25 Jul 2019 16:13:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 25 Jul 2019 18:13:20 +0200 (CEST)
Date:   Thu, 25 Jul 2019 18:13:17 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
Message-ID: <20190725161316.GI4707@redhat.com>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-5-christian@brauner.io>
 <20190725103543.GF4707@redhat.com>
 <20190725104006.7myahvjtnbcgu3in@brauner.io>
 <20190725112503.GG4707@redhat.com>
 <20190725114359.GH4707@redhat.com>
 <20190725122650.4i3arct5rpchqmyt@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725122650.4i3arct5rpchqmyt@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 25 Jul 2019 16:13:21 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 07/25, Christian Brauner wrote:
>
> The key is that you want to be able to create child processes in a
> shared library without the main programing having to know about this so
> that it can use P_ALL and never get stuff from the library.

OK, thanks...

in this case you should probablu pass 0 in CSIGNAL to ensure that the main
program won't be notified when that child exits.

Oleg.

