Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8F526B758
	for <lists+linux-api@lfdr.de>; Wed, 16 Sep 2020 02:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgIPAWY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 15 Sep 2020 20:22:24 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:53976 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgIPAWI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 15 Sep 2020 20:22:08 -0400
Date:   Tue, 15 Sep 2020 20:22:02 -0400
From:   Rich Felker <dalias@libc.org>
To:     linux-api@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] changes for addding fchmodat2 syscall
Message-ID: <20200916002157.GO3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I'm resubmitting this split into two parts, first blocking chmod of
symlinks in chmod_common, then adding the new syscall, as requested by
Christoph. This will make it impossible to chmod symlinks via the
O_PATH magic symlink path. I've also reordered the unsupported flags
test to come first.

Rich
