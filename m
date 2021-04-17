Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA21936312C
	for <lists+linux-api@lfdr.de>; Sat, 17 Apr 2021 18:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbhDQQ3J (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 17 Apr 2021 12:29:09 -0400
Received: from ciao.gmane.io ([116.202.254.214]:51766 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236541AbhDQQ3J (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 17 Apr 2021 12:29:09 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glka-linux-api@m.gmane-mx.org>)
        id 1lXnoH-0004yK-BH
        for linux-api@vger.kernel.org; Sat, 17 Apr 2021 18:28:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-api@vger.kernel.org
From:   sbaugh@catern.com
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another address space
Date:   Sat, 17 Apr 2021 12:28:16 -0400
Message-ID: <87sg3oub8f.fsf@catern.com>
References: <20210414055217.543246-1-avagin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Cancel-Lock: sha1:jpMprCTd32MZCM7B3C+YeTVd+a0=
Cc:     linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Just to add to the list of use cases for PROCESS_VM_EXEC_SYSCALL,
another use case is initializing a process from the "outside", instead
of from the "inside" as fork requires.  This can be much easier to work
with.  http://catern.com/rsys21.pdf goes into this use case in some
depth.

It relies heavily on a remote syscall primitive:
https://github.com/catern/rsyscall.  The PROCESS_VM_EXEC_SYSCALL API
proposed in this patch would be a great replacement for the current
implementation, which relies on running code inside the target process.

