Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3281A2C7BB7
	for <lists+linux-api@lfdr.de>; Sun, 29 Nov 2020 23:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgK2WbJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 29 Nov 2020 17:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgK2WbJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 29 Nov 2020 17:31:09 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CE6C0613CF;
        Sun, 29 Nov 2020 14:30:28 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A93591280A68;
        Sun, 29 Nov 2020 14:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1606689028;
        bh=O2JKWH7ZUGA7sCFY9kB0OpUQjAE5coW0PFTJWkwqGeM=;
        h=From:To:Subject:Date:Message-Id:From;
        b=WSLReXExHwcB3NzRQX1/nTb6YSjKXyckISOCiKnIpiHCUD2YsiHUC9E6fpbbu88LQ
         vI+VEMaTBC4b4kgpVhz2IYI5r9JDyLS0bsSWwB65SS4NtXdPMg2zyT+TxHyuU2GFYk
         uedwmwmAdIZgZgdupJz/QXMsdIme3E060+eqK9hA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Sfkbf8mGDSqK; Sun, 29 Nov 2020 14:30:28 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4635A1280A67;
        Sun, 29 Nov 2020 14:30:28 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-api@vger.kernel.org
Subject: [PATCH RESEND v4 0/1] add sysfs exports for TPM 2 PCR registers
Date:   Sun, 29 Nov 2020 14:30:21 -0800
Message-Id: <20201129223022.5153-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Cc to linux-api to get an opinion on two issues.  First the background:

We've had a fairly extensive discussion over on linux-integrity and
iterated to the conclusion that the kernel does need to export TPM 2.0
PCR values for use by a variety of userspace integrity programmes
including early boot.  The principle clinching argument seems to be
that these values are required by non-root systems, but in a default
Linux set up the packet marshalled communication device: /dev/tpmrm0,
is by default only usable by root.  Historically, TPM 1.2 exported
these values via sysfs in a single file containing all 24 values:

  /sys/class/tpm/tpm0/pcrs

with the format

  PCR-00: 7D 29 CB 08 0C 0F C4 16 7A 0E 9A F7 C6 D3 97 CD C1 21 A7 69 
  PCR-01: 9C B6 79 4C E4 4B 62 97 4C AB 55 13 1A 2F 7E AE 09 B3 30 BE 
  ...

TPM 2.0 adds more complexity: because of it's "agile" format, each TPM
2.0 is required to support a set of hashes (of which at least sha1 and
sha256 are required but quite a few TPM 2.0s have at least two or
three more) and maintain 24 PCR registers for each supported hash.
The current patch exports each PCR bank under the directory

  /sys/class/tpm/tpm0/pcr-<hash>/<bank>

So the sha256 bank value of PCR 7 can be obtained as

  cat /sys/class/tpm/tpm0/pcr-sha256/7
  2ED93F199692DC6788EFA6A1FE74514AB9760B2A6CEEAEF6C808C13E4ABB0D42

And the output is a single non-space separated ascii hex value of the
hash.

The issues we'd like input on are:

 1. Should this be in sysfs or securityfs?

  2. Should we export the values as one value per file (current patch)
     or as a binary blob of all 24?

I'm largely ambivalent about 1.  I can easily do securityfs output, it
is more work than sysfs largely because securityfs lacks most of the
features of sysfs, including the groups one that this patch uses
heavily, but that can all be open coded (as most other securityfs
consumers do).

I'm less ambivalent about the binary blob idea: pretty much every use
case we have requires a set of PCRs which are fewer than the 24 and a
lot only require a single PCR, so providing all 24 in a format that
has to be parsed seems to make life more difficult for the consuming
program.  The argument, at least, for providing the PCRs in binary
form is that most of the consuming programs, once they've selected
their set, tend to need the hash value of the set, which necessitates
converting from ascii to binary.  I do this by the simple script (for
PCRs say 1,6,7) as:

  cat /sys/class/tpm/tpm0/pcr-sha256/{1,6,7}|xxd -r -p|sha256sum

I've cc'd Jarkko, who's the main proponent of the binary blob use case
because he can make better arguments than I can.

Regards,

James

---

James Bottomley (1):
  tpm: add sysfs exports for all banks of PCR registers

 drivers/char/tpm/tpm-sysfs.c | 178 +++++++++++++++++++++++++++++++++++
 include/linux/tpm.h          |   9 +-
 2 files changed, 186 insertions(+), 1 deletion(-)

-- 
2.26.2

