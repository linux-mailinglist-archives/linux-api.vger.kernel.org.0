Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2ECD2C6C7F
	for <lists+linux-api@lfdr.de>; Fri, 27 Nov 2020 21:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgK0USY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 27 Nov 2020 15:18:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732323AbgK0UMA (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 27 Nov 2020 15:12:00 -0500
Received: from localhost.localdomain (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68798221FD;
        Fri, 27 Nov 2020 19:13:44 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Florian Weimer <fw@deneb.enyo.de>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Will Deacon <will@kernel.org>, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>
Subject: Re: [PATCH v4 1/2] arm64: mte: make the per-task SCTLR_EL1 field usable elsewhere
Date:   Fri, 27 Nov 2020 19:13:43 +0000
Message-Id: <160650438443.22092.12368244632759393865.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <b584bf342a38580daa7aa73eda72184e9453a5e4.1605842067.git.pcc@google.com>
References: <b584bf342a38580daa7aa73eda72184e9453a5e4.1605842067.git.pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 19 Nov 2020 19:29:46 -0800, Peter Collingbourne wrote:
> In an upcoming change we are going to introduce per-task SCTLR_EL1
> bits for PAC. Move the existing per-task SCTLR_EL1 field out of the
> MTE-specific code so that we will be able to use it from both the
> PAC and MTE code paths and make the task switching code more efficient.

Applied to arm64 (for-next/pac-keys-ctrl), thanks!

[1/2] arm64: mte: make the per-task SCTLR_EL1 field usable elsewhere
      https://git.kernel.org/arm64/c/e710c29e0177
[2/2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
      https://git.kernel.org/arm64/c/284c64e9eba3

If Dave has any other comments next week, we can apply them on top.

-- 
Catalin

