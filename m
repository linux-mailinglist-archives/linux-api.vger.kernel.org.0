Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B83BE543
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 20:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbfIYS7t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 14:59:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:39861 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731534AbfIYS7t (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 25 Sep 2019 14:59:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 11:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,549,1559545200"; 
   d="gz'50?scan'50,208,50";a="189751552"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Sep 2019 11:59:45 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iDCVs-00030L-Sa; Thu, 26 Sep 2019 02:59:44 +0800
Date:   Thu, 26 Sep 2019 02:59:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     kbuild-all@01.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] clone3: switch to copy_struct_from_user()
Message-ID: <201909260234.L6xAf4bZ%lkp@intel.com>
References: <20190925165915.8135-3-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4t2z22m6jg2hfmwp"
Content-Disposition: inline
In-Reply-To: <20190925165915.8135-3-cyphar@cyphar.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--4t2z22m6jg2hfmwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Aleksa,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.3 next-20190924]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Aleksa-Sarai/lib-introduce-copy_struct_from_user-helper/20190926-010527
config: xtensa-common_defconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=xtensa 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> lib/struct_user.o:(.text+0x8): undefined reference to `is_zeroed_user'
   lib/struct_user.o: In function `copy_struct_from_user':
   struct_user.c:(.text+0x37): undefined reference to `is_zeroed_user'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--4t2z22m6jg2hfmwp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--4t2z22m6jg2hfmwp--
