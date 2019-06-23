Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD7D4FB4F
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2019 13:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfFWLbh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 23 Jun 2019 07:31:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33246 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfFWLbh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 23 Jun 2019 07:31:37 -0400
X-Greylist: delayed 1359 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jun 2019 07:31:36 EDT
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf0Mf-00080j-Ge; Sun, 23 Jun 2019 13:08:53 +0200
Date:   Sun, 23 Jun 2019 13:08:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matthew Garrett <matthewgarrett@google.com>
cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH V34 20/29] x86/mmiotrace: Lock down the testmmiotrace
 module
In-Reply-To: <20190622000358.19895-21-matthewgarrett@google.com>
Message-ID: <alpine.DEB.2.21.1906231308420.32342@nanos.tec.linutronix.de>
References: <20190622000358.19895-1-matthewgarrett@google.com> <20190622000358.19895-21-matthewgarrett@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On Fri, 21 Jun 2019, Matthew Garrett wrote:

> From: David Howells <dhowells@redhat.com>
> 
> The testmmiotrace module shouldn't be permitted when the kernel is locked
> down as it can be used to arbitrarily read and write MMIO space. This is
> a runtime check rather than buildtime in order to allow configurations
> where the same kernel may be run in both locked down or permissive modes
> depending on local policy.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: David Howells <dhowells@redhat.com
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> cc: Thomas Gleixner <tglx@linutronix.de>
> cc: Steven Rostedt <rostedt@goodmis.org>
> cc: Ingo Molnar <mingo@kernel.org>
> cc: "H. Peter Anvin" <hpa@zytor.com>
> cc: x86@kernel.org

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
