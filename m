Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B23F7429
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2019 13:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKKMig (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 07:38:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48307 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfKKMif (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 07:38:35 -0500
Received: from p54ac5540.dip0.t-ipconnect.de ([84.172.85.64] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iU8xk-0000j9-VE; Mon, 11 Nov 2019 12:38:33 +0000
Date:   Mon, 11 Nov 2019 13:38:32 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 10/23] y2038: uapi: change __kernel_time_t to
 __kernel_old_time_t
Message-ID: <20191111123830.du25cahvat4ahg54@wittgenstein>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108211323.1806194-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191108211323.1806194-1-arnd@arndb.de>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 08, 2019 at 10:12:09PM +0100, Arnd Bergmann wrote:
> This is mainly a patch for clarification, and to let us remove
> the time_t definition from the kernel to prevent new users from
> creeping in that might not be y2038-safe.
> 
> All remaining uses of 'time_t' or '__kernel_time_t' are part of
> the user API that cannot be changed by that either have a
> replacement or that do not suffer from the y2038 overflow.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
