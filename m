Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A9C35F146
	for <lists+linux-api@lfdr.de>; Wed, 14 Apr 2021 12:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhDNKLI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 06:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233996AbhDNKKr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 14 Apr 2021 06:10:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55620613B1;
        Wed, 14 Apr 2021 10:10:24 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kostya Serebryany <kcc@google.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        libc-alpha@sourceware.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v8 1/3] arm64: mte: make the per-task SCTLR_EL1 field usable elsewhere
Date:   Wed, 14 Apr 2021 11:10:19 +0100
Message-Id: <161839488327.21932.16461913261970131291.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <13d725cb8e741950fb9d6e64b2cd9bd54ff7c3f9.1616123271.git.pcc@google.com>
References: <13d725cb8e741950fb9d6e64b2cd9bd54ff7c3f9.1616123271.git.pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 18 Mar 2021 20:10:52 -0700, Peter Collingbourne wrote:
> In an upcoming change we are going to introduce per-task SCTLR_EL1
> bits for PAC. Move the existing per-task SCTLR_EL1 field out of the
> MTE-specific code so that we will be able to use it from both the
> PAC and MTE code paths and make the task switching code more efficient.

Applied to arm64 (for-next/pac-set-get-enabled-keys).

Peter, can you please have a look and give it a try as part of the arm64
for-next/core branch? I rebased your patches on top of the
for-next/mte-async-kernel-mode branch as this was adding more code to
mte_thread_switch(), so I kept the function for now.

Thanks.

[1/3] arm64: mte: make the per-task SCTLR_EL1 field usable elsewhere
      https://git.kernel.org/arm64/c/2f79d2fc391e
[2/3] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
      https://git.kernel.org/arm64/c/201698626fbc
[3/3] arm64: pac: Optimize kernel entry/exit key installation code paths
      https://git.kernel.org/arm64/c/b90e483938ce

-- 
Catalin

