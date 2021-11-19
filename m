Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C29456EE9
	for <lists+linux-api@lfdr.de>; Fri, 19 Nov 2021 13:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhKSMkD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 19 Nov 2021 07:40:03 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36906 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhKSMkD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 19 Nov 2021 07:40:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6ADC212C6;
        Fri, 19 Nov 2021 12:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637325420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=uaAF6CCkpstXW9MyY4+bhhYNE9XKGDg8R4re1H+8Ka4=;
        b=sEjs8Fnes63nr7hudUQNDaiGh3ctZiDrf1Od1kcDAwJzAgBti3ZW0D28/Y9MBAjdMKlYwh
        RB0VZ5FJ/O2McdeTYSjzXUsfILl3BOoWyfvxi2aIuPHVB3WN7C/3AFiDFVLchqmp6yMhaD
        qbe0k3nvwgQvrYUH9h3yKgv89y6jSUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637325420;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=uaAF6CCkpstXW9MyY4+bhhYNE9XKGDg8R4re1H+8Ka4=;
        b=WFMRBfVDIm3siudv8dy0D3TXByX2smnmN5Tk3hEcQieyogwUUKUN3adHQQUHQb5HtpZ+PC
        2M26c+vVcIjZ9RAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B03D913B2A;
        Fri, 19 Nov 2021 12:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8aXLKWyal2GHTQAAMHmgww
        (envelope-from <chrubis@suse.cz>); Fri, 19 Nov 2021 12:37:00 +0000
Date:   Fri, 19 Nov 2021 13:38:06 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     linux-api@vger.kernel.org
Cc:     ltp@lists.linux.it, libc-alpha@sourceware.org
Subject: asm-generic/int-ll64.h wrongly used on x86_64?
Message-ID: <YZearmiVEw9/eor9@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi!
I was writing simple userspace code that prints the values from the
struct statx the line in question looks like:

	printf("%" PRIu64 "\n", st.stx_size);

This unexpectedly gives me warning on x86_64:

warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type '__u64' {aka 'long long unsigned int'}

Digging into the issue I've found that include/asm-generic/types.h looks like:

#ifndef _ASM_GENERIC_TYPES_H
#define _ASM_GENERIC_TYPES_H
/*
 * int-ll64 is used everywhere now.
 */
#include <asm-generic/int-ll64.h>

#endif /* _ASM_GENERIC_TYPES_H */

Which is the cause why you cannot print __u64 with PRIu64 and would
force every userspace code to explicitly cast any __u64 in order to get
rid warnings. I would say that it would be better to fix the headers so
that __u64 has the same type as uint64_t so that PRIu64 could be then
used to print __u64 as well.

-- 
Cyril Hrubis
chrubis@suse.cz
