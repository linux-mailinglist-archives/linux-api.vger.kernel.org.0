Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6218E19D6C7
	for <lists+linux-api@lfdr.de>; Fri,  3 Apr 2020 14:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgDCMeo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Apr 2020 08:34:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52182 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgDCMen (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Apr 2020 08:34:43 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jKLWq-0002W5-GD; Fri, 03 Apr 2020 12:34:32 +0000
Date:   Fri, 3 Apr 2020 14:34:31 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@openvz.or>,
        Adrian Reber <adrian@lisas.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH] ns: Fix time_for_children symlink
Message-ID: <20200403123431.tsvj6alagg3ee356@wittgenstein>
References: <a2418c48-ed80-3afe-116e-6611cb799557@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2418c48-ed80-3afe-116e-6611cb799557@gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Apr 03, 2020 at 02:11:39PM +0200, Michael Kerrisk (man-pages) wrote:
> Dmitry, Andrei,
> 
> Looking at the contents of the /proc/PID/ns/time_for_children
> symlink shows an anomaly:
> 
> $ ls -l /proc/self/ns/* |awk '{print $9, $10, $11}'
> ...
> /proc/self/ns/pid -> pid:[4026531836]
> /proc/self/ns/pid_for_children -> pid:[4026531836]
> /proc/self/ns/time -> time:[4026531834]
> /proc/self/ns/time_for_children -> time_for_children:[4026531834]
> /proc/self/ns/user -> user:[4026531837]
> ...
> 
> The reference for 'time_for_children' should be a 'time' namespace,
> just as the reference for 'pid_for_children' is a 'pid' namespace.
> In other words, I think the above time_for_children link should read:
> 
> /proc/self/ns/time_for_children -> time:[4026531834]
> 
> If you agree with this patch, then it should be marked for
> stable@vger.kernel.org.
> 
> Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>

Yeah, that just seems like an oversight.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
